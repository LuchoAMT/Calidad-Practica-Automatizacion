
After do 
    #Capybara.current_session.driver.quit
    Capybara.reset_sessions!
    Capybara.use_default_driver
end

Before '@maximize' do
  page.driver.browser.manage.window.maximize
end

# Before('@add_product_to_cart') do
#   step 'I click on the Add to cart button in the first product card'
# end

# Before('@add_product_and_checkout') do
#   step 'I click on the Add to cart button in the first product card'
#   step 'I click on the cart icon'
# end