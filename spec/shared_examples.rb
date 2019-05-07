RSpec.shared_examples 'User login' do |params|
  it 'User is logged in' do
    login_hash = { login: resolve_login(params[:login]), password: resolve_password(params[:password]),
                   remember: 'checked'.match?( (params[:remember]).to_s ) }
    LoginPage.open
    LoginPage.on { log_user_in(login_hash) }

    case params[:state]
    when :successful
      HomePage.on { expect(main_menu_section).to be_login_successful }
    when :failed
      LoginPage.on { is_expected.to be_login_failed }
    else
      raise 'Incorrect parameter :state'
    end

    @session_cookies = Capybara.page.driver.browser.manage.all_cookies
    # Capybara.current_session.reset_session!
  end
end

RSpec.shared_examples 'User re-opens browser' do
  it 'User reopens browser' do
    HomePage.open
    HomePage.on {driver.browser.manage.delete_all_cookies}

    @session_cookies.each {|cookie| HomePage.on {driver.browser.manage.add_cookie(cookie)}}
    HomePage.on { reload }
  end
end