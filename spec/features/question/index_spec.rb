require 'rails_helper'

feature 'User can show list of questions', %q{
  In order to get answer from a community
  As an authenticated user 
  Id like to see the list of questions
} do 
  
  given!(:questions){ create_list(:question, 5) }
  
  describe 'User' do
		scenario 'show the list of questions' do
		  visit questions_path
		  questions.each do |question|
      
      expect(page).to have_content question.title
		  expect(page).to have_content question.body
		  end
	  end
  end
end
