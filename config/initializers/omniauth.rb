Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['SLASHIFY_FACEBOOK_KEY'], ENV['SLASHIFY_FACEBOOK_SECRET'], :scope => 'email, publish_actions'
  provider :twitter, ENV['SLASHIFY_TWITTER_KEY'], ENV['SLASHIFY_TWITTER_SECRET']
end
