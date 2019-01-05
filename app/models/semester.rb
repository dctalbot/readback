class Semester < ActiveRecord::Base
  include Authority::Abilities
  has_many :freeform_shows, dependent: :destroy
  has_many :specialty_shows, dependent: :destroy
  has_many :talk_shows, dependent: :destroy

  validates :beginning, :ending, presence: true
  validate :semesters_dont_overlap
  validate :beginning_before_ending

  before_save :ensure_beginning_and_ending_are_at_six_am
  after_create { Signoff.propagate_all(beginning, ending) }

  default_scope { order(beginning: :desc) }

  def semesters_dont_overlap
    conflicts = Semester.all.select{ |s| (beginning - s.ending) * (s.beginning - ending) > 0 }

    return unless conflicts.any?
    conflicting_semesters = conflicts.map(&:id).to_sentence
    errors.add(:beginning, "Start or end date conflicts with semester #{conflicting_semesters}.")
  end

  def beginning_before_ending
    return unless beginning > ending
    errors.add(:beginning, 'Start date must be before end date.')
  end

  def self.current
    where('beginning < ?', Time.zone.now.noon).order(beginning: :desc).first ||
      last
  end

  def ensure_beginning_and_ending_are_at_six_am
    self.beginning = beginning.change(hour: 6, min: 0, sec: 0)
    self.ending = ending.change(hour: 5, min: 59, sec: 59)
  end

  def future?
    Time.zone.now < beginning
  end

  def range
    beginning.to_datetime..ending.to_datetime
  end

  def shows
    (freeform_shows + specialty_shows + talk_shows).select(&:on_schedule?)
  end

  def weeks
    range.count / 7
  end
end
