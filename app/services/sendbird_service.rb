# app/services/sendbird_service.rb

require 'faraday'
require 'json'

class SendbirdService
  BASE_URL = "https://api-#{ENV['SENDBIRD_APP_ID']}.sendbird.com/v3".freeze
  API_TOKEN = ENV['SENDBIRD_API_TOKEN'] # Assuming you have stored your API token in environment variables  

  def initialize(channel_url)
    @channel_url = channel_url
    @connection = Faraday.new(url: BASE_URL) do |faraday|
      faraday.request :json
      faraday.response :json, parser_options: { symbolize_names: true }
      faraday.adapter Faraday.default_adapter
      faraday.headers['Content-Type'] = 'application/json'
      faraday.headers['Api-Token'] = API_TOKEN
    end
  end


  def self.register_user(user)
    url = "#{BASE_URL}/users"
    
    profile_url = 'https://sendbird.com/main/img/profiles/profile_05_512px.png'

    # Make the HTTP request using Faraday
    response = Faraday.post(url) do |req|
      req.headers['Content-Type'] = 'application/json; charset=utf8'
      req.headers['Api-Token'] = API_TOKEN
      req.body = {
        user_id: user.id.to_s,
        nickname: user.username,
        profile_url: profile_url,
        issue_access_token: true,
      }.to_json
    end

    if response.status == 200
      response
    else
      Rails.logger.error "Error registering user with Sendbird: #{response.status} - #{response.body}"
      nil
    end
    rescue Faraday::ConnectionFailed => e
    Rails.logger.error "Connection failed: #{e.message}"
    nil
  end

  # create chat channel
  def self.create_channel(user1_id, user2_id)
    url = "#{BASE_URL}/group_channels"
    api_token = API_TOKEN
    payload = {
      user_ids: [user1_id, user2_id],
      is_distinct: true,
      name: "Chat between #{user1_id} and #{user2_id}"
    }.to_json

    response = Faraday.post(url) do |req|
      req.headers['Content-Type'] = 'application/json, charset=utf8'
      req.headers['Api-Token'] = api_token
      req.body = payload
    end

    OpenStruct.new(success?: response.status == 200, body: JSON.parse(response.body))
  rescue Faraday::ConnectionFailed, Faraday::TimeoutError => e
    Rails.logger.error "Sendbird API connection error: #{e.message}"
    OpenStruct.new(success?: false, body: { 'message' => 'Connection error', 'code' => 500 })
  end

  def send_message(user_id, message)
    body = {
      message_type: "MESG",
      user_id: user_id,
      message: message
    }

    @connection.post("/group_channels/#{@channel_url}/messages", body.to_json)
  end

end