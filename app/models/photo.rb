class Photo < ActiveRecord::Base
  attr_accessible :image_url, :width, :height, :filter, :user_id
      #uploader: (Digest::SHA2.new << m.user.username).to_s,

  has_many :faces

end