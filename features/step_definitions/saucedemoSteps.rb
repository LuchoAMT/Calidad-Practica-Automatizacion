Given("I login with correct credentials") do
    step "I browse to the saucedemo page"
    step "I enter \"#{ENV['USER']}\" in the username field"
    step "I enter \"#{ENV['PSW']}\" in the password field"
    step "I click on the \"Login\" button"
end


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

Then('I should see the following products with prices in order:') do |table|
   expected = table.raw.drop(1)
    actual = all('.inventory_item').map do |item|
        name = item.find('.inventory_item_name').text
        price = item.find('.inventory_item_price').text.delete('$').to_f
        [name, price.to_s]
    end

    expect(actual).to eq(expected)
end

Then('I should see the following data:') do |table|
    expected_data = table.raw.drop(1) # Skip the header row
    actual_data = all('.cart_item').map do |item|
        qty = item.find('.cart_quantity').text
        name = item.find('.inventory_item_name').text
        price = item.find('.inventory_item_price').text.delete('$').to_f
        [qty, name, price.to_s]
    end

    expect(actual_data).to eq(expected_data)
    puts "Displayed data matches the expected data"
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

Then("the following data is displayed:") do |table|
    expected_data = table.raw.drop(1) # Skip the header row
    actual_prods = all('.cart_item').map do |item|
        qty = item.find('.cart_quantity').text
        name = item.find('.inventory_item_name').text
        price = item.find('.inventory_item_price').text.delete('$')
        [qty, name, price.to_s]
    end

    tax = find('.summary_tax_label').text.delete('Tax: $')
    total = find('.summary_total_label').text.delete('Total: $')
    actual_data = actual_prods.map { |row| row + [tax, total] }

    expect(actual_data).to eq(expected_data)
    puts "Displayed data matches the expected data"
end

Given("I fill the checkout form with correct data") do
    step "I enter \"Jane\" in the First Name field"
    step "I enter \"Doe\" in the Last Name field"
    step "I enter \"12345\" in the Postal Code"
    puts "Checkout form filled with correct data"
end

Then("the Checkout: Complete page is shown") do
    completeLabel = find(:css, '#header_container > div.header_secondary_container > span').text
    expect(completeLabel).to eq('Checkout: Complete!')
    expect(page).to have_current_path('/checkout-complete.html')
    puts "Checkout: Complete page is displayed"
    puts "Current path: #{page.current_path}"
end