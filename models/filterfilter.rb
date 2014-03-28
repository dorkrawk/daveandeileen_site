require 'sequel'
require 'instagram'

class FilterFilter

  def initialize
    Instagram.configure do |config|
      config.client_id = ENV['INSTAGRAM_CLIENT_ID']
      config.client_secret = ENV['INSTAGRAM_CLIENT_SECRET']
    end

    db_type = ENV["B_W_DB_TYPE"]
    db_location = ENV["B_W_DB_LOCATION"]
    db_user = ENV["B_W_DB_USER"]
    db_pass = ENV["B_W_DB_PASS"]

    @db = Sequel.connect("#{db_type}://#{db_user}:#{db_pass}@#{db_location}")
  end

  def get_tagged_photo(tag)
    photo = Instagram.tag_recent_media(tag, {:count => 1})
    store_tagged_photo(photo[0])
  end

  def store_tagged_photo(photo)
    photo_url = "#{photo.images.standard_resolution.url}"
    screen_name = photo.user.username
    user_name = photo.user.full_name
    caption = photo.caption.text

    puts photo_url
    puts screen_name
    puts user_name
    puts caption
    @db[:photos].insert( :photo_url => photo_url , :service => "instagram", :username => screen_name, :name => user_name, :photo_text => caption)
  end
end