require 'sinatra/base'
require 'haml'

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

    get '/fact' do
      @page_title = "Facts..."
      haml :fact
    end
  end
end