Given(/^I browse to the saucedemo page$/) do
    visit('/')
end

When("I click on the {string} button") do |btn|
    # click_button(btn)
    find(:button, btn).click
    puts "Clicked on the #{btn} button"
    puts "Current path: #{page.current_path}"
end

Then("Products page is shown") do
    productsLabel = find(:css, '#header_container > div.header_secondary_container > span').text
    expect(page).to have_current_path('/inventory.html') 
    expect(productsLabel).to eq('Products')
    puts "Products page is displayed"
    puts "Current path: #{page.current_path}"
end #Separar el coso en 2, uno para el label y otro para el path

When ("I am in the Products page") do
    step "Products page is shown"
end

Then('I should see the following products:') do |table|
    expected_products = table.raw.flatten.drop(1)
    actual_products = all('.inventory_item_name').map(&:text)

    expect(actual_products).to match_array(expected_products)
end

When("I click on the cart icon") do
    find(:xpath, '/html/body/div/div/div/div[1]/div[1]/div[3]/a').click	
    puts "Clicked on the cart icon"
end

When('I click on the Add to cart button for the following products:') do |table|
  @clicked_products = table.raw.flatten.drop(1) # Skip the header row

  @clicked_products.each do |product_name|
    item = all('.inventory_item').find do |product|
      name_element = product.first('.inventory_item_name', minimum: 0)
      name_element && name_element.text == product_name
    end

    raise "Could not find product card for '#{product_name}'" unless item

    button = item.first('button', minimum: 0)
    raise "Could not find button for '#{product_name}'" unless button

    button.click
    puts "Clicked Add to cart on '#{product_name}'"
  end
end



Given("I add a product to the cart") do
    table = Cucumber::MultilineArgument::DataTable.from([["Product Name"], ["Sauce Labs Backpack"]])
    step "I click on the Add to cart button for the following products:"
    puts "Product added to cart"
end