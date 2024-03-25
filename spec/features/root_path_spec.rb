  require 'rails_helper'

  RSpec.feature 'Visiting the homepage', type: :feature do
    describe 'Home Page is Login form' do
      it 'should show login form' do
    
        visit root_path
        expect(page).to have_text 'Login'
        expect(page).to have_button 'Login'
        expect(page).to have_link 'Register'
        expect(page).to have_link 'Forgot your password?'

        expect(page).not_to have_text 'Welcome'
      end
    end
  end
