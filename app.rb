require 'sinatra/base'
require 'haml'

module DaveAndEileen
  class App < Sinatra::Base
    # routes
    get '/' do
      @page_title = "index"
      haml :index
    end
  end
end