require 'spec_helper'

RSpec.feature 'Remember Me' do
  # TC 03.2
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

  # TC 03.3
  context 'when User is logged in with remember-me feature and logs out' do
    it 'User stays logged out when Home page is reopened' do
      login_hash = { login: resolve_login(:correct), password: resolve_password(:correct),
                     remember: true }
      LoginPage.open
      LoginPage.on { log_user_in(login_hash) }

      HomePage.on { expect(main_menu_section).to be_login_successful }

      HomePage.on { main_menu_section.logout }

      session_cookies = Capybara.page.driver.browser.manage.all_cookies

      Capybara.reset_sessions!

      HomePage.open
      HomePage.on {driver.browser.manage.delete_all_cookies}

      session_cookies.each { |cookie| HomePage.on { driver.browser.manage.add_cookie(cookie) }}

      HomePage.on { reload }

      HomePage.on { expect(main_menu_section).to be_logout_successful }
    end
  end
end
