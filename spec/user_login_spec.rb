require 'spec_helper'

# TC 02, 03.1, 04.1-04.3, 05.1-05.3
RSpec.feature 'User login' do
  parameters = Array.new
  parameters << { login: :correct,   password: :correct,   remember: :unchecked, state: :successful }
  parameters << { login: :correct,   password: :correct,   remember: :checked,   state: :successful }
  parameters << { login: :empty,     password: :correct,   remember: :unchecked, state: :failed     }
  parameters << { login: :correct,   password: :empty,     remember: :unchecked, state: :failed     }
  parameters << { login: :empty,     password: :empty,     remember: :unchecked, state: :failed     }
  parameters << { login: :incorrect, password: :correct,   remember: :unchecked, state: :failed     }
  parameters << { login: :correct,   password: :incorrect, remember: :unchecked, state: :failed     }
  parameters << { login: :incorrect, password: :incorrect, remember: :unchecked, state: :failed     }

  parameters.each do |p|
    context 'when User logs in with correct credentials' do
      it 'he is logged in' do
        login_hash = { login: resolve_login(p[:login]), password: resolve_password(p[:password]), remember: 'checked'.match?( (p[:remember]).to_s ) }
        LoginPage.open
        LoginPage.on { log_user_in(login_hash) }

        case p[:state]
        when 'successful'
          HomePage.on { expect(main_menu_section).to be_login_successful }
        when 'failed'
          LoginPage.on { is_expected.to be_login_failed }
        end
      end
    end
  end
end

def resolve_login(login)
  possible_login = { 'correct': Howitzer.app_test_user, 'incorrect': 'blabla@mail.net', 'empty': ''}
  possible_login[login.to_sym]
end

def resolve_password(password)
  possible_password = { 'correct': Howitzer.app_test_pass, 'incorrect': '12345678', 'empty': ''}
  possible_password[password.to_sym]
end