require 'rails_helper'

feature 'User can sign out', %q{
  In order to qo out As 
  an authenticated user
  Id like to be to sign out
}do
	given(:user){create(:user)}

	scenario 'Redistered user can sign out' do 
		visit new_user_session_path	
		fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
    click_on 'Sign out'
    
    expect(page).to have_content 'Signed out successfully.'
	end
end