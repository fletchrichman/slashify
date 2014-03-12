class Photo < ActiveRecord::Base
      #uploader: (Digest::SHA2.new << m.user.username).to_s,

  has_many :faces

end