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


Then("Add to cart button should change to Remove for those products") do
    @clicked_products.each do |product_name|
    product = all('.inventory_item').find do |item|
      item.has_css?('.inventory_item_name', text: product_name)
    end

    raise "Product '#{product_name}' not found" unless product

    button = product.find('button')
    expect(button.text).to eq('Remove'), "Expected 'Remove' for '#{product_name}', but got '#{button.text}'"
    puts "Verified 'Remove' for '#{product_name}'"
  end
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