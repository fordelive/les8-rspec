RSpec.shared_examples 'User logs in' do |parameters|
  context "when User logs in with #{parameters[:login]} login and #{parameters[:password]} password and #{parameters[:remember]} Remember Me option " do
    it 'he is logged in' do
      login_hash = { login: resolve_login(parameters[:login]), password: resolve_password(parameters[:password]),
                     remember: 'checked'.match?( (parameters[:remember]).to_s ) }
      LoginPage.open
      LoginPage.on { log_user_in(login_hash) }

      case parameters[:state]
      when :successful
        HomePage.on { expect(main_menu_section).to be_login_successful }
      when :failed
        LoginPage.on { is_expected.to be_login_failed }
      else
        raise 'Incorrect :state parameter'
      end
    end
  end
end