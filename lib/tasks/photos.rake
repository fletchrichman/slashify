namespace 'photos' do
  require 'instagram'

  desc 'Download selfies from Instagram'
  task :load_from_instagram => :environment do |t|

    min_id = 0

    token = ENV['INSTAGRAM_CLIENT_TOKEN']

    @ps = PhotoService.new
    puts "-- Hitting Instagram for media tagged with #{ENV["TAG"]}, min_id #{min_id}"

    # Get all the media, y0
    media = HTTParty.get("https://api.instagram.com/v1/tags/#{ENV['TAG']}/media/recent?access_token=#{token}")

    #puts "-- #{media.count} results returned from Instagram"
    media = media.parsed_response['data']
    media.each do |m|
     #  puts "-- Processing media item #{m.id}"

      # If we try to run a video through OpenCV all hell is going to break loose, so make sure we're only getting images from Instagram
      # Irritatingly we can't filter this through the API call (sigh), so have to do it here.
      if m['type'] != 'image'
        puts "--- Media is not an image, skipping"
        next
      end

      # if ExcludedUser.where(username: m['user']['username']).any?
      #   puts "--- User has requested exclusion, skipping"
      #   next
      # end

      p = Photo.new({      
        photo_url: m['images']['standard_resolution']['url'],
        width: m['images']['standard_resolution']['width'],
        height: m['images']['standard_resolution']['height']
      })
      p.save
      @ps.download_and_process(p)
    end

    puts "-- All media processed"

    # Update the min_id, have a little sleep for 10 seconds so we don't hit any rate limits (fat chance with the
    # time it takes to process these images, however it might be a concern if you're using an obscure hashtag)
    #min_id = media.pagination.min_tag_id
  end
end