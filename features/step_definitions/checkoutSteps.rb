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
    actual_data = all('.cart_item').map do |item|
        qty = item.find('.cart_quantity').text
        name = item.find('.inventory_item_name').text
        price = item.find('.inventory_item_price').text.delete('$')
        [qty, name, price.to_s]
    end

    expect(actual_data).to eq(expected_data)
    puts "Displayed data matches the expected data"
end

Then("the tax should be correctly calculated as {float}") do |expected_tax|
  item_prices = all('.inventory_item_price').map { |el| el.text.delete('$').to_f }
  subtotal = item_prices.sum
  actual_tax = find('.summary_tax_label').text.delete('Tax: $').to_f

  calculated_tax = (subtotal * 0.08).round(2) # Saucedemo usa 8%
  expect(actual_tax).to eq(expected_tax)
  expect(actual_tax).to eq(calculated_tax)
  puts "Tax verified as #{actual_tax}, calculated from subtotal #{subtotal}"
end

Then("the total should be correctly calculated as {float}") do |expected_total|
  item_prices = all('.inventory_item_price').map { |el| el.text.delete('$').to_f }
  subtotal = item_prices.sum
  tax = find('.summary_tax_label').text.delete('Tax: $').to_f
  expected_total = (subtotal + tax).round(2)

  actual_total = find('.summary_total_label').text.delete('Total: $').to_f

  expect(actual_total).to eq(expected_total)
  puts "Total verified: #{actual_total} = #{subtotal} + #{tax}"
end


Given("I fill the checkout form with the following data:") do |table|
    data = table.rows_hash # Skip the header row
    step %{I enter "#{data['first name']}" in the First Name field}
    step %{I enter "#{data['last name']}" in the Last Name field}
    step %{I enter "#{data['postal code']}" in the Postal Code}
    puts "Checkout form filled with correct data"
end

Then("the Checkout: Complete page is shown") do
    completeLabel = find(:css, '#header_container > div.header_secondary_container > span').text
    expect(completeLabel).to eq('Checkout: Complete!')
    expect(page).to have_current_path('/checkout-complete.html')
    puts "Checkout: Complete page is displayed"
    puts "Current path: #{page.current_path}"
end

