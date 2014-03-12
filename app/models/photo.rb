class Photo < ActiveRecord::Base

  has_many :faces

  def filtered_for_json
    { photo_url: self.photo_url, faces: self.relative_faces }
  end

  def relative_faces
    photo_width = self.width.to_f
    photo_height = self.height.to_f

    self.faces.map do |face|
      width  = face['width'].to_f
      height = face['height'].to_f
      left   = face['left'].to_f
      top    = face['top'].to_f

      # Get the skewed face width (width - 15% of the width), unskewed face
      # width, and subsequently calculated width skew as percentages
      width_skewed   = (((width - (width * 0.15)) / photo_width) * 100).round(2)
      width_unskewed = ((width / photo_width) * 100).round(2)
      width_skew     = width_unskewed - width_skewed

      left = (((left / photo_width) * 100) + (width_skew / 2)).round(2)
      top  = (((top - (height * 0.1)) / photo_height) * 100).round(2)

      {
        width: width_skewed,
        top: top,
        left: left
      }
    end
  end
end