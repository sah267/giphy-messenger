require 'rubygems'
require 'twilio-ruby'
require 'sinatra'
require 'sinatra/base'
require 'net/http'
require_relative './lib/messenger'


get '/' do
  erb :index, locals: {title: 'My Twilio App'}
end

get '/giphy' do
  uri = URI('http://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC')


  giphy = Net::HTTP.get(uri)
  parsed = JSON.parse(giphy)

  image = parsed['data']['image_original_url']

  erb :giphy, locals: {image: image}
end

get '/send' do

  phone_number = params[:phone]
  message = params[:message]

  uri = 'http://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC'

  if message
    uri += '&tag=' + message
  end

  uri = URI(uri)

  giphy = Net::HTTP.get(uri)
  parsed = JSON.parse(giphy)

  image = parsed['data']['image_original_url']

  Messenger.send_sms_notifications(phone_number, message, image)

  'Sent'

end