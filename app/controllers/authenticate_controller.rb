class AuthenticateController < ApplicationController
  def index    
    @authentications = current_user.authentications if current_user
  end

  def create
    omniauth = request.env["omniauth.auth"] 
    authentication = Authentication.from_omniauth(omniauth)
    reset_session
    session[:user_id] = authentication.user.id
    redirect_to authenticate_index_path, :notice => 'Signed in!'
  end

end
