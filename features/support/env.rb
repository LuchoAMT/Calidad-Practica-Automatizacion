begin require 'rspec/expectations'; rescue LoadError; require 'spec/expectations'; end
require 'capybara'
require 'capybara/dsl'
require 'capybara/cucumber'
require 'capybara-screenshot/cucumber'
require 'selenium-webdriver'
#require 'webdrivers/chromedriver'

#PTravel Settings
ENV['USER']="standard_user"
ENV['PSW']="secret_sauce"

Capybara.default_driver = :selenium

# Set the host the Capybara tests should be run against
Capybara.app_host = ENV["CAPYBARA_HOST"]

# Set the time (in seconds) Capybara should wait for elements to appear on the page
Capybara.default_max_wait_time = 15
Capybara.default_driver = :selenium
Capybara.app_host = "https://www.saucedemo.com"

class CapybaraDriverRegistrar
  # register a Selenium driver for the given browser to run on the localhost
  def self.register_selenium_driver(browser)
    Capybara.register_driver :selenium do |app|
      options = Selenium::WebDriver::Chrome::Options.new

      prefs = {
        'credentials_enable_service' => false,
        'profile.password_manager_enabled' => false
      }
      options.add_preference(:prefs, prefs)

      options.add_argument('--guest')
      options.add_argument('--disable-save-password-bubble')
      options.add_argument('--disable-infobars')
      options.add_argument('--disable-extensions')
      options.add_argument('--disable-translate')
      options.add_argument('--start-maximized')
      options.add_argument('--no-sandbox')
      options.add_argument('--disable-dev-shm-usage')
      options.add_argument('--disable-notifications')
      options.add_argument('--disable-popup-blocking')
      options.add_argument('--disable-features=PasswordLeakDetection')
      options.add_argument('--disable-setuid-sandbox')
      options.add_argument('--reduce-security-for-testing')
      # options.add_argument('--password-store=basic') # Use basic password store
      # options.add_argument('--disable-web-security') # Disable web security for testing

      Capybara::Selenium::Driver.new(app, browser: browser, options: options)
    end
  end

end
# Register various Selenium drivers
#CapybaraDriverRegistrar.register_selenium_driver(:internet_explorer)
#CapybaraDriverRegistrar.register_selenium_driver(:firefox)
CapybaraDriverRegistrar.register_selenium_driver(:chrome)
Capybara.run_server = false
#World(Capybara)

