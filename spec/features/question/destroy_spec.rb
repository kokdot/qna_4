require 'rails_helper'

feature 'User can destroy your answer and question', %q{
  In order to get answer for a community
  As an authenticated user 
  Id like to able to destroy your answer and question
} do 

  given(:user){ create(:user) }
  given!(:question){ create(:question, user: user) }
  given!(:answer){ create(:answer, question: question, user: user) }

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
    expect(page).to_not have_content "#{question.title}"
  end


  
  scenario 'destroy not your question' do
    click_on 'Sign out'
    user_1 = create(:user)
    sign_in(user_1)
    visit questions_path
    click_on "#{question.title}"
    within("p#id#{question.id}") do
      click_on 'Destroy'
    end
    
    expect(page).to have_content 'Your can destroy only your question.'
  end
  
	scenario 'destroy your  answer' do
    click_on "#{question.title}"
    within("p#id#{answer.id}") do
      click_on 'Destroy'
    end

    expect(page).to have_content 'Your answer successfully destroyed.'
  end


  scenario 'destroy not your  answer' do
    click_on 'Sign out'
    user_1 = create(:user)
    sign_in(user_1)
    visit questions_path
    click_on "#{question.title}"
    within("p#id#{answer.id}") do
      click_on 'Destroy'
    end

    expect(page).to have_content 'Your can destroy only your answer.'
  end
  
end