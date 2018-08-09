require 'twilio-ruby'

namespace :sms do

  desc "Send good morning sms messages to today's djs who opted-in. Run daily at 2:15AM"
  task remind_todays_djs: :environment do
    now = Time.zone.now
    range = (now)..(now + 1.day)
    episodes = Episode.where beginning: range
    episodes.each do |episode|
      if episode.dj.sms_on
        SmsRemindersJob.perform_later episode
      end
    end
  end
end
