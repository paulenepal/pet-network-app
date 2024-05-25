# app/services/sendbird_service.rb

require 'faraday'
require 'json'

class SendbirdService
  BASE_URL = "https://api-#{ENV['SENDBIRD_APP_ID']}.sendbird.com/v3".freeze

  def self.register_user(user_id, nickname)
    url = "#{BASE_URL}/users"
    api_token = ENV['SENDBIRD_API_TOKEN'] # Assuming you have stored your API token in environment variables

    # # Prepare user data
    # user_data = {
    #   user_id: user_id,
    #   nickname: nickname,
    #   issue_access_token: true
    # }

    # # Prepare multipart request for file upload (if profile file is provided)
    # if profile_file_path
    #   profile_file = Faraday::UploadIO.new(profile_file_path, 'application/octet-stream')
    #   payload = { profile_file: profile_file, user: user_data }
    # else
    #   payload = user_data
    # end

    # Make the HTTP request using Faraday
    response = Faraday.post(url) do |req|
      req.headers['Content-Type'] = 'multipart/form-data'
      req.headers['Api-Token'] = api_token
      req.body = { user_id: user_id, nickname: nickname }.to_json
    end

    # Handle response
    if response.success?
      # User registration successful
      puts "User registered successfully with Sendbird"
    else
      # Error handling
      puts "Error registering user with Sendbird: #{response.status} - #{response.body}"
    end
  end
end
