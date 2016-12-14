require 'twilio-ruby'

class Messenger
  def self.send_sms_notifications(phone_number, message, image_url)
    new.send_sms_notifications(phone_number, message, image_url)
  end

  def initialize
    account_sid = 'ACa96662fb03827c636c41623c32a21e91'
    auth_token  = 'd7460700606e9a04bd7e4dff4e3f3c9c'
    @client = Twilio::REST::Client.new(account_sid, auth_token)
  end

  def send_sms_notifications(phone_number, message, image_url)
    send_sms(phone_number, message, image_url)
  end

  private

  def send_sms(phone_number, message, image_url)

    begin
      @client.account.messages.create(
          from:      '+17745411130',
          to:        phone_number,
          body:      '/giphy' + message,
          media_url: image_url
      )
    rescue
      return 'error'
    else
      return 'success'
    end
  end
end