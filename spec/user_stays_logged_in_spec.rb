require 'spec_helper'

# TC 03.2
RSpec.feature 'Remember Me' do
  context 'when User is logged in with remember-me feature' do
    login_params = { login: :correct, password: :correct, remember: :checked, state: :successful }
    include_examples 'User login', login_params
    include_examples 'User re-opens browser'

    it 'User is logged in when login page is re-opened' do
      HomePage.on { expect(main_menu_section).to be_login_successful }
    end
  end
end
