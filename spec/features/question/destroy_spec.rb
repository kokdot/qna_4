require 'rails_helper'

feature 'User can destroy your question', %q{
  In order to get answer for a community
  As an authenticated user 
  Id like to able to destroy your question
} do 

  given(:user){ create(:user) }
  given!(:question){ create(:question, user: user) }

  background do 
    sign_in(user)
    visit questions_path
  end
  
  scenario 'destroy your question' do
    click_on "#{question.title}"
    within("p#id#{question.id}") do
      click_on 'Destroy'
    end
    
    expect(page).to have_content 'Your question successfully destroyed.'
    expect(page).to_not have_content question.title
  end
end
