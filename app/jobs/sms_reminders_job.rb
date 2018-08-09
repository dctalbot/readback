class SmsRemindersJob < ApplicationJob
  queue_as :default

  def perform(episode)
    account_sid = "AC2e97a1c5ba570fc3d4cb20b42a860221" # Twilio SID
    auth_token = "secret"   # Auth Token (SECRET)

    @client = Twilio::REST::Client.new account_sid, auth_token
    message = @client.messages.create(
        body: "Good morning! You've got a show later today at" + episode.beginning + ". If you need a sub, get one NOW. You can opt out of this by editing your dj profile",
        to: "+1" + dj.phone, #TODO format the phone
        from: "+16312121167")
  end
end
