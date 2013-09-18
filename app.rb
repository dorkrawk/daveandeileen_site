require 'sinatra/base'
require 'haml'
require './models/facts'
require './models/blog'

module DaveAndEileen
  class App < Sinatra::Base
    d_and_e_blog = Blog.new
    # routes
    get '/' do
      @page_title = "index"
      @blog_posts = d_and_e_blog.get_posts
      haml :index
    end

    get '/aboutus' do
      @page_title = "About Dave and Eileen"
      @blog_posts = d_and_e_blog.get_posts
      haml :aboutus
    end

    get '/backstory' do
      @page_title = "About Dave and Eileen"
      @blog_posts = d_and_e_blog.get_posts
      haml :backstory
    end

    get '/party_animals' do
      @page_title = "The Wedding Party"
      @blog_posts = d_and_e_blog.get_posts
      haml :party
    end

    get '/parade' do
      @page_title = "Wedding Parade!"
      @blog_posts = d_and_e_blog.get_posts
      haml :parade
    end

    get '/photos' do 
      @page_title = "Photos"
      @blog_posts = d_and_e_blog.get_posts
      haml :photos
    end

    get '/facts/:id' do
      @page_title = "Facts..."
      @blog_posts = d_and_e_blog.get_posts
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
                      "are altering their lives",
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
  end
end