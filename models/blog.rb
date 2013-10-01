require 'feedzirra'

module DaveAndEileen
  class Blog

    feed_address = "http://daveandeileen.wordpress.com/feed"

    @@feed = Feedzirra::Feed.fetch_and_parse(feed_address)

    def get_posts(x=5)
      if feed_ok?
        num_posts = [x, @@feed.entries.count].min
        @@feed.entries.take(num_posts)
      else
        []
      end
    end 

    def num_posts
      @@feed.entries.count
    end

    def feed_ok?
      !@@feed.nil?
    end

  end
end