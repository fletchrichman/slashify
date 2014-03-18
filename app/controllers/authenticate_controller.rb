class AuthenticateController < ApplicationController
  def index    
    @authentications = current_user.authentications if current_user
  end

  def create
    omniauth = request.env["omniauth.auth"] 
    authentication = Authentication.from_omniauth(omniauth)
    session[:user_id] = authentication.user.id
    photo = Photo.find(session[:photo_id])
    if authentication.provider == 'facebook'
      facebook = Koala::Facebook::API.new(authentication.token)
      facebook.put_picture(photo.photo_url, {:message => "I Slashified myself with PivotDesk!"})
    elsif authentication.provider == 'twitter'
      twitter = TwitterClient.new(authentication)
      twitter.tweet_with_image(photo)
      redirect_to photo_path(photo_id)
    else
      redirect_to authenticate_index_path, :notice => 'Unknown Authentication'
    end
  end

end
