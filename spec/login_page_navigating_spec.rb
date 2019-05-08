require 'spec_helper'

# TC 01
RSpec.feature 'Login page navigating' do
  context 'by clicking Login menu item' do
    it 'User navigates to Login page' do
      HomePage.open
      HomePage.on { main_menu_section.login }

      expect(LoginPage).to be_displayed
    end
  end
end