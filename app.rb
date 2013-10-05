require 'sinatra/base'
require 'haml'
require 'twitter-text'
require './models/twitter'
require './models/facts'
require './models/blog'
require './env' if File.exists?('env.rb')

include Twitter::Autolink

module DaveAndEileen
  class App < Sinatra::Base
    @@wedding_date = DateTime.new(2014,8,2)

    # routes
    get '/' do
      @page_title = "index"
      haml :index
    end

    get '/aboutus' do
      @page_title = "About Dave and Eileen"
      haml :aboutus
    end

    get '/backstory' do
      @page_title = "About Dave and Eileen"
      haml :backstory
    end

    get '/party_animals' do
      @page_title = "The Wedding Party"
      haml :party
    end

    get '/details' do
      @page_title = "Wedding Details"
      haml :details
    end

    get '/photos' do 
      @page_title = "Photos"
      haml :photos
    end

    get '/facts/:id' do
      @page_title = "Facts..."
      @fact = a_fact(params[:id])
      haml :fact
    end

    @@the_subtitles = [
                      "are entering the bonds of matrimony and cheese",
                      "are totally getting married",
                      "are taking names and taking vows",
                      "are getting hitched",
                      "are tying the knot",
                      "are saying 'I do' (and maybe some other words)",
                      "are better off wed",
                      "are wandering down the aisle",
                      "are joining forces",
                      "are altaring their lives",
                      "are merging their resources",
                      "are making honest people out of eachother",
                      "are fit to be tying the knot",
                      "are wedlocking it down"
                    ]

    def get_subtitle
      @@the_subtitles.sample
    end

    def countdown
      days = (@@wedding_date - DateTime.now).to_i
      "#{days} days"
    end

    def countdown_exact

    end 

    helpers do
      def tweets
        our_twitters = ["dorkrawk", "leenbeener"]
        twitter = BirdBlender.new(our_twitters, ENV['TWITTER_CONSUMER_KEY'], ENV['TWITTER_CONSUMER_SECRET'], ENV['TWITTER_OAUTH_TOKEN'], ENV['TWITTER_OAUTH_TOKEN_SECRET'])
        twitter.tweets
      end

      def nice_tweet(tweet)
        auto_link(tweet)
      end 

      def us_photos

      end

      def blog_posts
        d_and_e_blog = Blog.new
        d_and_e_blog.get_posts
      end

      def is_i?(word)
        !!(word =~ /^[-+]?[0-9]+$/)
      end

      def a_fact(id)
        the_facts = Facts.new
        if is_i?(id)
          @fact_id = Integer(id)
        else
          # get random fact
          @fact_id = (0..the_facts.count-1).to_a.sample
        end
        the_facts.get_fact(@fact_id)
      end
    end
  end
end