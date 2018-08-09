require 'twilio-ruby'

namespace :sms do

  desc "Send good morning sms messages to today's djs who opted-in. Run daily at 2:15AM"
  task remind_todays_djs: :environment do
    now = Time.zone.now
    range = (now)..(now + 1.day)
    episodes = Episode.where beginning: range
    episodes.each do |episode|
      if episode.dj.sms_on
        account_sid = "AC2e97a1c5ba570fc3d4cb20b42a860221" # Twilio SID
        auth_token = "secret"   # Auth Token (SECRET) TODO remove

        @client = Twilio::REST::Client.new account_sid, auth_token
        message = @client.messages.create(
            body: "Good morning! You've got a show later today at" + episode.beginning + ". If you need a sub, get one NOW. You can opt out of this by editing your dj profile",
            to: "+16318965058",
            from: "+16312121167")
      end
    end
  end
end
