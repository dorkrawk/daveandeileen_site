require 'sequel'

class BirdWatcher

  def initialize
    db_type = ENV["B_W_DB_TYPE"]
    db_location = ENV["B_W_DB_LOCATION"]
    db_user = ENV["B_W_DB_USER"]
    db_pass = ENV["B_W_DB_PASS"]

    # connect to the Birdwatcher DB
    @db = Sequel.connect("#{db_type}://#{db_user}:#{db_pass}@#{db_location}")

    # pull photos
    current_photos = @db[:photos].select_all

    @photos = current_photos.to_hash(:id)
    @most_recent_id = current_photos.max(:id)

    # no new photos yet
    @new_photos = Hash.new
  end

  def update
    new_photo_set = @db[:photos].where('id > ?', @most_recent_id)
    @new_photos.merge!(new_photo_set.to_hash(:id))
    @most_recent_id = new_photo_set.max(:id)
  end

  def get_photo
    unless @new_photos.empty?
      # pull a random photo from @new_photos, add it to @photos, remove from @new_photos
      photo = @new_photos[@new_photos.keys.sample]
      @photos.merge!(photo)
      @new_photos.delete(photo[:id])

      photo
    else
      @photos[@photos.keys.sample]
    end
  end

  def get_photo_json
    photo = get_photo
    photo.to_json
  end
end