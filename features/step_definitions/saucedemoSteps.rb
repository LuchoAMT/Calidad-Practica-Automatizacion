Given(/^I browse to the saucedemo page$/) do
    page.driver.browser.manage.window.maximize
    visit('/')
end

When("I enter {string} in the username field") do |username|
    fill_in('user-name', with: username)
end

When("I enter {string} in the password field") do |password|
    fill_in('password', with: password)
end

When("I click on the {string} button") do |btn|
    # click_button(btn)
    find(:button, btn).click
    puts "Clicked on the #{btn} button"
    puts "Current path: #{page.current_path}"
end

Then('error {string} is shown') do |message|
    errorMessage = find('[data-test="error"]', wait: 2).text
    # errorMessage = find(:xpath, '//h3[@data-test="error" or contains(@class, "error-message")]', wait: 2).text
    expect(errorMessage).to eq(message)
    puts "Error message: #{errorMessage}"
end


Given("I login with correct credentials") do
    step "I browse to the saucedemo page"
    step "I enter \"#{ENV['USER']}\" in the username field"
    step "I enter \"#{ENV['PSW']}\" in the password field"
    step "I click on the \"Login\" button"
end

Then("Products page is shown") do
    productsLabel = find(:css, '#header_container > div.header_secondary_container > span').text
    expect(page).to have_current_path('/inventory.html') 
    expect(productsLabel).to eq('Products')
    puts "Products page is displayed"
    puts "Current path: #{page.current_path}"
end #Separar el coso en 2, uno para el label y otro para el path

Then("first item is {string}") do |itemName|
    firstItemName = all('.inventory_item_name').first.text
    expect(firstItemName).to eq(itemName)
    puts "First item name: #{firstItemName}"
end

When ("I am in the Products page") do
    step "Products page is shown"
end

When("I click on the Add to cart button in the first product card") do
    first_add_to_cart_button = all('.btn_primary.btn_inventory').first
    first_add_to_cart_button.click
    puts "Clicked on the first Add to cart button"
end

Then("Add to cart button should change to Remove") do
    first_button_text = all('.btn_secondary.btn_inventory').first.text
    expect(first_button_text).to eq('Remove')
    puts "First button text after click: #{first_button_text}"
    sleep 2
end

Then("I should see {int} product cards displayed") do |product_count|
    product_cards = all('.inventory_item')
    actual_count = product_cards.size
    puts "Found #{actual_count} product(s) on the page"
    expect(actual_count).to eq(product_count)

end

When("I click on the product sort box") do 
    find(:css, '#header_container > div.header_secondary_container > div > span > select').click
    puts "Clicked on the product sort box"
end

When("I click on {string} option from the product sort box") do |sort_option|
    find('[data-test="product-sort-container"]').select(sort_option)
    puts "Selected sort option: #{sort_option}"
end

Then("first item price is {float}") do |price|
    first_price_text = all('.inventory_item_price').first.text
    first_price = first_price_text.gsub('$', '').to_f
    expect(first_price).to eq(price)
    puts "First item price: #{first_price}"
end

Given("I add a product to the cart") do
    step "I click on the Add to cart button in the first product card"
    puts "Product added to cart"
end

When("I click on the cart icon") do
    find(:xpath, '/html/body/div/div/div/div[1]/div[1]/div[3]/a').click	
    puts "Clicked on the cart icon"
end

Then("Your Cart page is shown") do
    cartLabel = find(:css, '#header_container > div.header_secondary_container > span').text
    expect(cartLabel).to eq('Your Cart')
    expect(page).to have_current_path('/cart.html')
    puts "Your Cart page is displayed"
    puts "Current path: #{page.current_path}"
end #Separar el coso en 2, uno para el label y otro para el path?

Then("the cart badge should be {int}") do |badgeCount|
    cartBadge = find(:css, '#shopping_cart_container > a > span').text.to_i
    expect(cartBadge).to eq(badgeCount)
    puts "Cart badge count: #{cartBadge}"
end

Then("the Checkout: Your Information is shown") do
    checkoutLabel = find(:css, '#header_container > div.header_secondary_container > span').text
    expect(checkoutLabel).to eq('Checkout: Your Information')
    expect(page).to have_current_path('/checkout-step-one.html')
    puts "Checkout: Your Information page is displayed"
    puts "Current path: #{page.current_path}"
end

When("I enter {string} in the First Name field") do |first_name|
    find('#first-name', wait: 3)
    fill_in('first-name', with: first_name)
    puts "Entered First Name: #{first_name}"
    #puts "value entered in First Name field: #{find('#first-name').value}"
end

When("I enter {string} in the Last Name field") do |last_name|
    find('#last-name', wait: 3)
    fill_in('last-name', with: last_name)
    puts "Entered Last Name: #{last_name}"
    #puts "value entered in Last Name field: #{find('#last-name').value}"
end

When("I enter {string} in the Postal Code") do |zipcode|
    find('#postal-code', wait: 3)
    fill_in('postal-code', with: zipcode)
    puts "Entered Zip/Postal Code: #{zipcode}"
    #puts "value entered in Postal Code field: #{find('#postal-code').value}"
end

When("I click on the Continue button in checkout page") do
    sleep 2
    Capybara.using_wait_time(5) do
        continue_button = find('#continue', visible: true)
    
    end    # find('#continue', wait: 2).click
    puts "Clicked on the Continue button in checkout page"
end

Then("error {string} is shown in checkout page") do |error_message|
    errorMessage = find(:css, '#checkout_info_container > div > form > div.checkout_info > div.error-message-container.error > h3', wait: 5).text
    expect(errorMessage).to eq(error_message)
    puts "Error message in checkout page: #{errorMessage}"
end

Then ("the Checkout: Overview page is shown") do
    overviewLabel = find(:css, '#header_container > div.header_secondary_container > span').text
    #expect(overviewLabel).to eq('Checkout: Overview')
    expect(page).to have_current_path('/checkout-step-two.html', wait: 3)
    puts "Checkout: Overview page is displayed"
    puts "Current path: #{page.current_path}"
end