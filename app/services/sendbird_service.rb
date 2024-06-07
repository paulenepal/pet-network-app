# app/services/sendbird_service.rb
require 'faraday'
require 'json'
class SendbirdService
  BASE_URL = "https://api-#{ENV['SENDBIRD_APP_ID']}.sendbird.com/v3".freeze
  API_TOKEN = ENV['SENDBIRD_API_TOKEN'].freeze
  def initialize
    @connection = Faraday.new(url: BASE_URL) do |faraday|
      faraday.request :json
      faraday.response :json, parser_options: { symbolize_names: true }
      faraday.adapter Faraday.default_adapter
      faraday.headers['Content-Type'] = 'application/json'
      faraday.headers['Api-Token'] = API_TOKEN
    end
    # check_connection
  end
  # def check_connection
  #   response = @connection.get('/applications')
  #   if response.success?
  #     puts "Successfully connected to Sendbird API"
  #   else
  #     puts "Failed to connect to Sendbird API: #{response.status} - #{response.body}"
  #   end
  # rescue Faraday::ConnectionFailed => e
  #   puts "Connection failed: #{e.message}"
  # rescue Faraday::TimeoutError => e
  #   puts "Connection timed out: #{e.message}"
  # rescue StandardError => e
  #   puts "An error occurred: #{e.message}"
  # end
   # register user in senbird account
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

  # Get list of users from Sendbird
  def get_list_users
    url = "#{BASE_URL}/users"
    response = @connection.get(url)
    handle_response_fetch_users(response)
  rescue Faraday::ConnectionFailed => e
    Rails.logger.error "Connection failed: #{e.message}"
    nil
  end

   # create group channel
   def create_group_channel(current_user_id, target_user_id)
    url = "#{BASE_URL}/group_channels"
    response = Faraday.post(url) do |req|
      req.headers['Content-Type'] = 'application/json; charset=utf8'
      req.headers['Api-Token'] = API_TOKEN
      req.body = {
        name: "Chat between #{current_user_id} and #{target_user_id}",
        user_ids: [current_user_id, target_user_id],
        is_distinct: true
      }.to_json
    end
    response.body
  end
  # post message to a group channels
  def send_message(channel_url, user_id, message)
    url = "#{BASE_URL}/group_channels/#{channel_url}/messages"
    response = Faraday.post(url) do |req|
      req.headers['Content-Type'] = 'application/json; charset=utf8'
      req.headers['Api-Token'] = API_TOKEN
      req.body = {
        user_id: user_id,
        message_type: "MESG",
        message: message
      }.to_json
    end
    response.body
  end
  # Fetch messages from a group channel
  def fetch_messages(channel_url)
    channel_type = "group_channels"
    url = "#{BASE_URL}/#{channel_type}/#{channel_url}/messages?message_ts=0&next_limit=200"
    response = @connection.get(url)
    handle_response_fetch_messages(response)
  end
  private
  def handle_response_fetch_users(response)
    if response.success?
      response.body[:users] # Make sure this returns an array of user hashes
    else
      Rails.logger.error "Failed to fetch users from Sendbird: #{response.status} - #{response.body}"
      []
    end
  end
  def handle_response_fetch_messages(response)
    if response.success?
      response.body
    else
      error_message = "Failed to fetch messages from Sendbird: #{response.status} - #{response.body.to_s}"
      Rails.logger.error error_message
      { error: error_message }
    end
  end
end