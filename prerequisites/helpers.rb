def resolve_login(login)
  possible_login = { 'correct': Howitzer.app_test_user, 'incorrect': 'blabla@mail.net', 'empty': ''}
  possible_login[login.to_sym]
end

def resolve_password(password)
  possible_password = { 'correct': Howitzer.app_test_pass, 'incorrect': '12345678', 'empty': ''}
  possible_password[password.to_sym]
end
