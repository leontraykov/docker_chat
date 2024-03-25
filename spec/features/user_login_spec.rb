  require 'rails_helper'

  RSpec.feature 'User logining', type: :feature do
    let(:user) { create(:user) }

    describe 'Visiting the login page filling the form and submit' do
      it 'should let user in and show the greeting' do
    
        visit root_path

        expect(page).to have_button 'Login'

        fill_in :user_email, with: user.email
        fill_in :user_password, with: user.password

        click_button 'Login'
        expect(page).to have_text 'Welcome'
  
      end
    end
  end
