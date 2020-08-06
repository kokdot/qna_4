require 'rails_helper'

feature 'User can see the list of answers for questions', %q{
  In order to get answer from a community
  As a authenticated user
  Id like to see the list of answers for question
} do

  given(:user){ create(:user) }
  given!(:question){ create(:question) }
  given!(:answers){ create_list(:answer, 3, question: question) }

  background do 
	  sign_in(user)
  end

  scenario 'show answers' do
    visit questions_path
	  click_on "#{question.title}"
	  expect(page).to have_content "#{answers[0].body}"
	  expect(page).to have_content "#{answers[1].body}"
	  expect(page).to have_content "#{answers[2].body}"
  end
end
