class TwitterClient
  require 'twitter'

  def initialize(authentication)
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['SLASHIFY_TWITTER_KEY']
      config.consumer_secret     = ENV['SLASHIFY_TWITTER_SECRET'] 
      config.access_token        = authentication.token
      config.access_token_secret = authentication.secret
    end
  end

  def client
    @client
  end

end 
