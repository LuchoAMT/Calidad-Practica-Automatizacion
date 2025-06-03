Given(/^I browse to the saucedemo page$/) do
    page.driver.browser.manage.window.maximize
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

Then('I should see the following products:') do |table|
    expected_products = table.raw.flatten.drop(1)
    actual_products = all('.inventory_item_name').map(&:text)

    expect(actual_products).to match_array(expected_products)
end