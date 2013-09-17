require 'feedzirra'

module DaveAndEileen
  class Blog

    feed_address = "http://daveandeileen.wordpress.com/feed"

    @@feed = Feedzirra::Feed.fetch_and_parse(feed_address)

    def get_posts(x=5)
      num_posts = [x, @@feed.entries.count].min
      @@feed.entries.take(num_posts)
    end 

    def num_posts
      @@feed.entries.count
    end

  end
end