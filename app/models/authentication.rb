class Authentication < ActiveRecord::Base
    belongs_to :user

  def self.from_omniauth(omniauth)
    Authentication.where(:provider => omniauth['provider'], :uid => omniauth['uid'], :secret => omniauth['secret']).first || Authentication.create_with_omniauth(omniauth)
  end 

  def self.create_with_omniauth(auth)
    user = User.create(:name => 'Unknown')
    newauth = Authentication.create(:provider => auth['provider'], :uid => auth['uid'], :secret => auth['secret'], :user_id => user.id)
  end


end
