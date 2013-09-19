require 'sinatra/base'
require 'haml'
require './models/facts'
require './models/blog'

module DaveAndEileen
  class App < Sinatra::Base

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
      the_facts = Facts.new
      if is_i?(params[:id])
        @fact_id = Integer(params[:id])
      else
        # get random fact
        @fact_id = (0..the_facts.count-1).to_a.sample
      end
      @fact = the_facts.get_fact(@fact_id)
      haml :fact
    end

    def is_i?(word)
      !!(word =~ /^[-+]?[0-9]+$/)
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
                      "are merging their resources"
                    ]

    def get_subtitle
      @@the_subtitles.sample
    end

    def countdown
      wedding_date = DateTime.new(2014,8,2)
      days = (wedding_date - DateTime.now).to_i
      "#{days} days"
    end

    helpers do
      def blog_posts
        d_and_e_blog = Blog.new
        d_and_e_blog.get_posts
      end
    end
  end
end