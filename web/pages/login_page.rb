class LoginPage < Howitzer::Web::Page
  path '/users/sign_in'
  validate :title, /Demo web application - Login form\z/

  element :field_email, "#user_email"
  element :field_password, "#user_password"
  element :btn_submit, "input[name='commit']"
  element :checkbox_remember_me, "label[for='user_remember_me']"
  element :flash_alert, "#flash_alert"

  def login_failed?
    flash_alert_element.visible?
  end

  def log_user_in( login_hash )
    field_email_element.set login_hash[:login]
    field_password_element.set login_hash[:password]
    checkbox_remember_me_element.click if login_hash[:remember]

    btn_submit_element.click
  end
end