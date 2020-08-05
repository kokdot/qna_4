require 'rails_helper'

feature 'User can destroy your answer', %q{
  In order to get answer for a community
  As an authenticated user 
  Id like to able to destroy your answer
} do 

  given(:user){ create(:user) }
  given!(:question){ create(:question, user: user) }
  given!(:answer){ create(:answer, question: question, user: user) }

  background do 
    sign_in(user)
    visit questions_path
  end
  
  scenario 'destroy your  answer' do
    click_on "#{question.title}"
    within("p#id#{answer.id}") do
      click_on 'Destroy'
    end

    expect(page).to have_content 'Your answer successfully destroyed.'
  end
end
