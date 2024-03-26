# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Registration process', type: :feature do
  describe 'Registrtion Page has Signup form' do
    it 'new user with should be registred' do
      visit root_path
      click_link 'Register'
      expect(page).to have_button 'Register'

      fill_in :user_name, with: 'Brian'
      fill_in :user_email, with: 'emiail@ex.com'
      fill_in :user_password, with: 'password'
      fill_in :user_password_confirmation, with: 'password'

      click_button 'Register'
      expect(page).to have_text 'Welcome'
    end
  end
end
