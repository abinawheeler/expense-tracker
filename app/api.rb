require 'sinatra/base'
require 'json'

module ExpenseTracker
  class API < Sinatra::Base
    post '/expenses' do
      #send back (responce body) Json including expense
      JSON.generate('expense_id' => 42)
    end
    
    #route for reading back data 
    get '/expenses/:date' do
      JSON.generate([])
    end
  end
end