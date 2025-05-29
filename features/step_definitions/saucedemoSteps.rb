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

When("I click on the Login button") do
    click_button('Login')
end

Then('error {string} is shown') do |message|
    errorMessage = find(:xpath, '/html/body/div/div/div[2]/div[1]/div/div/form/div[3]/h3').text
    expect(errorMessage).to eq(message)
    puts "Error message: #{errorMessage}"
end


Given("I login with correct credentials") do
    step "I browse to the saucedemo page"
    step "I enter \"#{ENV['USER']}\" in the username field"
    step "I enter \"#{ENV['PSW']}\" in the password field"
    step "I click on the Login button"
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
end #Separar el coso en 2, uno para el label y otro para el path

