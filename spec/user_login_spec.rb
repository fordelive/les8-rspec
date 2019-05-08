require 'spec_helper'

# TC 02, 03.1, 04.1-04.3, 05.1-05.3
RSpec.feature 'User login' do
  parameters = [{ login: :correct,   password: :correct,   remember: :unchecked, state: :successful }]
  parameters << { login: :correct,   password: :correct,   remember: :checked,   state: :successful }
  parameters << { login: :empty,     password: :correct,   remember: :unchecked, state: :failed     }
  parameters << { login: :correct,   password: :empty,     remember: :unchecked, state: :failed     }
  parameters << { login: :empty,     password: :empty,     remember: :unchecked, state: :failed     }
  parameters << { login: :incorrect, password: :correct,   remember: :unchecked, state: :failed     }
  parameters << { login: :correct,   password: :incorrect, remember: :unchecked, state: :failed     }
  parameters << { login: :incorrect, password: :incorrect, remember: :unchecked, state: :failed     }

  parameters.each do |p|
    include_examples 'User logs in', p
  end
end