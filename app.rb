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

    get '/fact/:id' do
      @page_title = "Facts..."
      fact_id = Integer(params[:id])
      the_facts = Facts.new
      facts = the_facts.get_facts
      @fact = facts[fact_id]["fact"]
      haml :fact
    end
  end
end