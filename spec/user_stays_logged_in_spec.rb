require 'spec_helper'

# TC 03.2
RSpec.feature 'Remember Me' do
  context 'when User is logged in with remember-me feature' do
    it 'User stays logged in when Home page is reopened' do
      login_hash = { login: resolve_login(:correct), password: resolve_password(:correct),
                     remember: true }
      LoginPage.open
      LoginPage.on { log_user_in(login_hash) }

      HomePage.on { expect(main_menu_section).to be_login_successful }

      session_cookies = Capybara.page.driver.browser.manage.all_cookies

      Capybara.reset_sessions!

      HomePage.open
      HomePage.on {driver.browser.manage.delete_all_cookies}

      session_cookies.each { |cookie| HomePage.on { driver.browser.manage.add_cookie(cookie) }}

      HomePage.on { reload }

      HomePage.on { expect(main_menu_section).to be_login_successful }
    end
  end
end
