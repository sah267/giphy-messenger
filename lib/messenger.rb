require 'yaml'
require 'twilio-ruby'

class Messenger
  def self.send_sms_notifications(phone_number, message, image_url)
    new.send_sms_notifications(phone_number, message, image_url)
  end

  def initialize
    account_sid = 'ACa96662fb03827c636c41623c32a21e91'
    auth_token  = 'd7460700606e9a04bd7e4dff4e3f3c9c'
    @client = Twilio::REST::Client.new(account_sid, auth_token)

    puts @client
  end

  def send_sms_notifications(phone_number, message, image_url)
    puts 'send message'

    alert_message = 'Hello'
    # image_url = 'http://howtodocs.s3.amazonaws.com/new-relic-monitor.png'

    send_sms(phone_number, message, image_url)

      # admins = YAML.load_file('config/administrators.yml')
    # admins.each do |admin|
    #   phone_number = admin['phone_number']
    #   send_sms(phone_number, alert_message, image_url)
    # end
  end

  private

  def send_sms(phone_number, message, image_url)
    puts @client

    @client.account.messages.create(
        from:      '+17745411130',
        to:        phone_number,
        body:      message,
        media_url: image_url
        # media_url: image_url
    )
  end
end