# This class is example of section
class MenuSection < Howitzer::Web::Section
  me 'div.navigation__wrapper'

  element :log_in, :link, 'Login'
  element :log_out, :link, 'Logout'

  # element :menu_button, '.menuButton'
  # element :account, :xpath, ".//*[@id='metaMenu']//a[contains(., 'Account')]"
  # element :log_out, :xpath, ".//*[@id='metaMenu']//a[contains(., 'Log Out')]"

  def login
    Howitzer::Log.info 'Log in'
    log_in_element.click
  end

  def logout
    Howitzer::Log.info 'Log out'
    log_out_element.click
  end

  def login_successful?
    log_out_element.visible?
  end

  def logout_successful?
    log_in_element.visible?
  end
end
