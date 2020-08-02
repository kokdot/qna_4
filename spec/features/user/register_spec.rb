require 'rails_helper'

feature 'User can register in', %q{
  In order to ask question As 
  an authenticated user
  Id like to be to register in
}do

	scenario 'User tries to register in correctly' do 
		visit questions_path
		click_on 'Ask question'
		click_on 'Sign up'
		fill_in 'Email', with: 'test@email.com'
    fill_in 'Password', with: '12341234'
    fill_in 'Password confirmation', with: '12341234'
		click_on 'Sign up'
		
    expect(page).to have_content 'Welcome! You have signed up successfully.'
		
	end

	scenario 'User tries to register in uncorrectly' do 
		visit questions_path
		click_on 'Ask question'
    click_on 'Sign up'
		click_on 'Sign up'
		
    expect(page).to have_content "Email can't be blank"
		
	end
end

