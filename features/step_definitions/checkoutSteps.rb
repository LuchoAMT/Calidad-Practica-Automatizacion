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