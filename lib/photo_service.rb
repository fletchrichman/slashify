require "fileutils"
require "digest"

class PhotoService

  def initialize
  	@detector = OpenCV::CvHaarClassifierCascade::load(File.expand_path(File.dirname(__FILE__) + '/haar.xml'))
  end

  def download_and_process(photo)
    # Define where we're going to whack this image temporarily.
    # All Instagram images are jpegs for now
    output_file = "tmp/#{photo.id}.jpg"
    puts output_file

    begin
      # Download the image via wget. This is remarkably dubious and will silently fail, hence why this whole thing is wrapped in a try/catch
      # Should definitely be refactored to at least check if we get output to stderr
      `wget --quiet -O #{output_file} #{photo.photo_url}`

      detect_faces(output_file, photo)
    rescue => e
      puts "!!! Something went horrendously wrong during the download/face recognition phase - skipping"
      puts "!!! #{e}"
      return nil
    ensure
      # Make sure we trash the temporarily downloaded image
      FileUtils.rm_f(output_file)
    end

    return true if photo.faces.any?
    return nil
  end

  def detect_faces(file, photo)
  	
  	cv_image = OpenCV::CvMat.load(file)

    @detector.detect_objects(cv_image).each do |region|
      next if region.width < 150 # Smaller faces are more likely to be false-positives and aren't as funny, so skip them

      f = Face.new
      f.width = region.width
      f.height = region.height
      f.top = region.top_left.y
      f.left = region.top_left.x
      f.photo = photo
      f.save

      # eye detection goes here
    end
  end
end