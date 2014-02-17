require 'twitter'

module DaveAndEileen
  class BirdBlender
    include Twitter::Autolink

    def initialize(accounts, consumer_key, consumer_secret, access_token, access_token_secret)
      Twitter.configure do |config|
        config.consumer_key       = consumer_key 
        config.consumer_secret    = consumer_secret 
        config.oauth_token        = access_token 
        config.oauth_token_secret = access_token_secret
      end

      if accounts.is_a? Array
        @accounts = accounts
      else 
        @accounts = []
      end
    end

    def tweets(num = 10)
      all_tweets = Array.new
      # this is bad and lazy, redo this
      @accounts.each do |a|
        all_tweets += Twitter.user_timeline(a).take(num)
      end
      all_tweets.sort_by! { |t| t.id}.reverse! 
      all_tweets.take(num)
    end

    def merge_tweets

    end

    private :merge_tweets
  end
end
    