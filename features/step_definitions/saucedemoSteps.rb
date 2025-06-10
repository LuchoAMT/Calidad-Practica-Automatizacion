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


Then("Add to cart button should change to Remove") do
    first_button_text = all('.btn_secondary.btn_inventory').first.text
    expect(first_button_text).to eq('Remove')
    puts "First button text after click: #{first_button_text}"
    sleep 2
end
#no lo estoy usando xd
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



#MENU LATERAL
When("I click on the burguer menu button") do
    find(:xpath, '/html/body/div/div/div/div[1]/div[1]/div[1]/div/div[1]/div/button').click	
    puts "Clicked on the burguer menu button"
end

Then("I should see the following options:") do |table|
  expected_options = table.raw.flatten.drop(1)
  # encuentra el NAV
  nav = find(:xpath, '//*[@id="menu_button_container"]/div/div[2]/div[1]/nav', wait: 3)
  # busca todos los <a>
  actual_options = nav.all('a').map(&:text)
  expect(actual_options).to include(*expected_options)
  puts "Menu options found via XPath: #{actual_options}"
end



When("I click on the {string} option") do |option|
  nav = find(:css, '#menu_button_container > div > div.bm-menu-wrap > div.bm-menu > nav')
  link = nav.find('a', text: option, match: :prefer_exact, wait: 3)
  link.click
  puts "Clicked on nav option: #{option}"
end



Then("I should see the text {string}") do |expected_text|
  expect(page).to have_text(expected_text)
  puts "Text '#{expected_text}' is present on the page."
end