class Face < ActiveRecord::Base

  belongs_to :photo

  # width  = face['width'].to_f
  #     height = face['height'].to_f
  #     left   = face['left'].to_f
  #     top    = face['top'].to_f

end