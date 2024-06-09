class TwilioSmsSender
  def initialize(to:, body:)
    @to = to
    @body = body
  end

  def call
    client = Twilio::REST::Client.new
    client.messages.create(
      from: ENV['TWILIO_PHONE_NUMBER'],
      to: @to,
      body: @body
    )
  rescue Twilio::REST::TwilioError => e
    Rails.logger.error "Twilio Error: #{e.message}"
    false
  end
end