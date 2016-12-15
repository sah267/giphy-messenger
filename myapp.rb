require 'rubygems'
require 'twilio-ruby'
require 'sinatra'
require 'sinatra/base'
require 'net/http'
require_relative './lib/messenger'

# Render Index View for '/' route
get '/' do
    erb :index, locals: {message: '', result: 'success'}
end

# route called when form is submitted that sends giph SMS to inputed number
get '/send' do

    # Get query params
    phone_number = params[:phone]
    giphy_tag = params[:tag]

    # Build URI for giphy API call
    uri = 'http://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC'

    if giphy_tag
        uri += '&tag=' + giphy_tag
    end

    uri = URI(uri)

    # Do Giphy API call
    giphy = Net::HTTP.get(uri)

    # Parse returned data to JSON
    parsed = JSON.parse(giphy)

    # Check if valid response (data is an empty array if no giphs were found)
    # and set template vars
    if parsed['data'].kind_of?(Array)

        message = '<span class="glyphicon glyphicon-exclamation-sign"></span>  No Giphs Found! Try a different search term.'
        result = 'error'

    else

        # if valid, get giph url
        image = parsed['data']['image_original_url']

        # send SMS
        test = Messenger.send_sms_notifications(phone_number, giphy_tag, image)

        # If send was successful, set successflt templates vars, else set error vars
        if test == 'success'

            message = '<span class="glyphicon glyphicon-ok-sign"></span>  Success! Giphy sent successfully!'
            result = 'success'

        else

            message = '<span class="glyphicon glyphicon-exclamation-sign"></span>  Oops! Sorry Something went wrong. Please try again.'
            result = 'error'

        end
    end

    # Render index template
    erb :index, locals: { message: message, result: result}

end