require 'rubygems'
require 'twilio-ruby'
require 'sinatra'
require 'sinatra/base'
require 'net/http'
require_relative './lib/messenger'


get '/' do
  erb :index, locals: {title: 'My Twilio App', message: '', result: 'success'}
end

get '/send' do

  phone_number = params[:phone]
  giphy_tag = params[:tag]

  uri = 'http://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC'

  if giphy_tag
    uri += '&tag=' + giphy_tag
  end

  uri = URI(uri)

  giphy = Net::HTTP.get(uri)

  parsed = JSON.parse(giphy)

  if parsed['data'].kind_of?(Array)
    puts 'does not exist'

    test = 'No Giphs Found!'
    result = 'error'
  else
    puts 'it exists!'

    image = parsed['data']['image_original_url']

    test = Messenger.send_sms_notifications(phone_number, giphy_tag, image)

    if test == 'success'
      message = 'Success! Giphy sent successfully!'
      result = 'success'
    else
      message = 'Error: Sorry Something went wrong'
      result = 'error'
    end
  end

  erb :index, locals: {title: 'My Twilio App', message: message, result: result}

end