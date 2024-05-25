# app/services/sendbird_channel_service.rb
class SendbirdChannelService
  def self.create_channel(user_ids, name = nil)
    response = Sendbird::GroupChannel.create(
      user_ids: user_ids.map(&:to_s),
      name: name
    )
    handle_response(response)
  end

  private

  def self.handle_response(response)
    if response['error']
      Rails.logger.error "SendBird error: #{response['error']}"
      nil
    else
      response
    end
  end
end
