require 'sinatra/base'
require 'haml'
require './models/facts'

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

    get '/photos' do 
      @page_title = "Photos"
      haml :photos
    end

    get '/fact/:id' do
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
  end
end