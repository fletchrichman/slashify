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

  def tweet_with_image(photo)
    begin
    uri = URI.parse(photo.photo_url)
    media = uri.open
    media.instance_eval("def original_filename; '#{File.basename(uri.path)}'; end")
    @client.update_with_media("I slashified myself with @PivotDesk! #{request.original_url}", media)
      rescue => e
    end
  end

end 
