require 'rails_helper'

feature 'User can create answer', %q{
  In order to get answer for a community
  As an authenticated user 
  Id like to able to write an answer
} do

  context 'authenticated user' do
    given(:user){ create(:user) }
    given!(:question){ create(:question, user: user) }

    background do 
      sign_in(user)
    end

    background do 
      visit questions_path
      click_on "#{question.title}"
    end
    
    scenario 'write an answer' do
      fill_in 'Body', with: 'answer answer answer'
      click_on 'Answer'

      expect(page).to have_content 'Your answer successfully created.'
      expect(page).to have_content 'answer answer answer'
    end

    scenario 'write a answer with errors' do
      click_on 'Answer'

      expect(page).to have_content "Body can't be blank"
    end
  end

  context 'unauthenticated user' do
    given!(:question){ create(:question) }
    
    scenario 'write an answer' do
      visit questions_path
      click_on "#{question.title}"
      fill_in 'Body', with: 'answer answer answer'
      click_on 'Answer'
      
      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end
  end
end
