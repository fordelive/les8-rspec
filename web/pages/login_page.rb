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

  def log_user_in(user_login, user_password, remember_me = false)
    field_email_element.set user_login
    field_password_element.set user_password
    checkbox_remember_me_element.click if remember_me

    btn_submit_element.click
  end
end