module Show
  extend ActiveSupport::Concern

  included do
    belongs_to :semester
    has_many :episodes, as: :show, dependent: :destroy

    include Authority::Abilities
    self.authorizer_name = 'OwnedModelAuthorizer'
    
    validates :name, :duration, presence: true

    validate :show_does_not_conflict_with_any_other
    after_create :propagate
    after_update :propagate_if_changed
  end

  include Recurring

  def show_does_not_conflict_with_any_other
    return nil if times && times.recurrence_rules.empty?
    return nil if $DO_NOT_PERFORM_SHOW_CONFLICT_VALIDATION
    conflicts = (semester.shows - [self])
      .reject { |x| x.times && x.times.recurrence_rules.empty? }
      .select { |x| times.conflicts_with? x.times }
    if conflicts.any?
      errors.add(:time, " conflict with #{conflicts.map(&:unambiguous_name).to_sentence}.")
    end
  end

  def propagate_if_changed
    if times_changed?
      episodes.reject(&:past?).each(&:destroy)
      propagate
    elsif dj_id_changed?
      episodes.normal.each do |ep|
        ep.update_attributes(dj_id: dj_id)
      end
    end
  end

  def set_times_conditionally_from_params(params)
    duration = params[:duration].to_f.hours
    bg = Time.zone.parse params[:beginning]
    wd = (params[:weekday].to_i + weekday_offset(bg.hour)) % 7
    unless self.times && wd == self.times.first.wday &&
        bg.hour == self.times.first.hour && bg.min == self.times.first.min &&
        duration == self.times.duration
      set_times weekday: wd, hour: bg.hour, minute: bg.min, duration: duration
    end
  end

  def set_times(weekday:, hour:, minute:, duration:, sem: semester)
    self.times = IceCube::Schedule.new(sem.beginning)
    self.times.duration = duration
    self.times.add_recurrence_rule(
      IceCube::Rule
      .weekly
      .day(weekday)
      .hour_of_day(hour)
      .minute_of_hour(minute)
      .until(sem.ending)
    )
  end

  def most_recent_episode
    episodes.select { |ep| ep.beginning < Time.zone.now }
      .sort_by(&:beginning).last
  end

  def unambiguous_name
    name
  end

  def time_string
    "<span style=\"display:inline-table\">(#{["Sunday", "Monday", "Tuesday",
                                             "Wednesday", "Thursday", "Friday",
                                             "Saturday"][weekday]}s,
    #{beginning.strftime("%l:%M")} &ndash; #{
        ending.strftime("%l:%M%P")})</span>".html_safe
  end

  def sort_times t
    return nil if times.nil?
    {sortable: ((send(t) - 6.hours).seconds_since_midnight),
     printable: (send(t).strftime '%l:%M %P')}
  end

  def beginning
    times.first  unless times.nil? || times.recurrence_rules.empty?
  end
  
  def ending
    beginning + duration.hours  if beginning
  end

  def weekday
    unless times.nil? || times.recurrence_rules.empty?
      (times.first.wday - weekday_offset) % 7
    else
      -1
    end
  end

  def duration
    (times.duration / 60.0 / 60.0) rescue nil
  end

  def destroy
    if episodes.select(&:past?).any?
      episodes.reject(&:past?).each &:destroy
      update_columns times: nil
    else
      super
    end
  end

  private
  def weekday_offset(hour = beginning.hour)
    return 1 if (0...6).include? hour
    0
  end

  def instance_collection_name
    "episodes"
  end

  def instance_params(t)
    {beginning: t, ending: t + duration.hours, status: default_status, dj: dj}
  end

end

class Time
  def hms
    {hour: hour, min: min, sec: sec}
  end
end
