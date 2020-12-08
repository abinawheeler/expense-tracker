require 'rack/test'
require 'json'
require_relative '../../app/api'

module ExpenseTracker
  RSpec.describe 'Expense Tracker API' do 
    include Rack::Test::Methods 
    
    def app
      ExpenseTracker::API.new
    end
    
   
    def post_expense(expense)
      
      #test the route 
      post '/expenses', JSON.generate(expense)
      expect(last_response.status).to eq(200)
      
      #expect the responce from the app to be a hash containing expense_id of integer value
      parsed = JSON.parse(last_response.body)
      expect(parsed).to include('expense_id'=> a_kind_of(Integer))
      
      #add a id key to the hash - we will be able to compare 
      expense.merge('id' => parsed['expense_id'])
    end
    
    it 'records submitted expenses' do
      pending 'Need to persist expenses'
      coffee = post_expense(
        'payee'  => 'Starbucks',
        'amount' => 5.75,
        'date'   => '2017-06-10'
      )

      zoo = post_expense(
        'payee'  => 'Zoo',
        'amount' => 15.25,
        'date'   => '2017-06-10'
      )

      groceries = post_expense(
        'payee'  => 'Whole Foods',
        'amount' => 95.20,
        'date'   => '2017-06-11'
      )
      # POST coffee, zoo, and groceries expenses here
     
      #test the route and query all expenses the 10_06_10
      get '/expenses/2017-06-10'
      expect(last_response.status).to eq(200)
        
      expenses = JSON.parse(last_response.body)
      expect(expenses).to contain_exactly(coffee, zoo)
    end
    
      
   
    
    
  end
end