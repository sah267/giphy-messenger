require 'twilio-ruby'

# Messenger class for sending SMS notifications
class Messenger
    def self.send_sms_notifications(phone_number, message, image_url)
        new.send_sms_notifications(phone_number, message, image_url)
    end

    # Initialize twilio client
    def initialize
        account_sid = 'ACf5289c0b265d65b7440c27340aa1d0db'
        auth_token = 'f2893578e96202c5d48c4bdf00c0fd9e'
        @client = Twilio::REST::Client.new(account_sid, auth_token)
    end

    # Public sms function
    def send_sms_notifications(phone_number, message, image_url)
        send_sms(phone_number, message, image_url)
    end

    private

    # private send SMS function
    # Params:
    #    phone_number {String}
    #    message {String} the giphy search text
    #    image_url {String} giphy url
    def send_sms(phone_number, message, image_url)

        # try to create message, if fail send 'error' else 'success'
        begin
            @client.account.messages.create(
                from: '+16176525171',
                to: phone_number,
                body: '/giphy ' + message,
                media_url: image_url
            )
        rescue
            return 'error'
        else
            return 'success'
        end
    end
end