When("I enter {string} in the username field") do |username|
    fill_in('user-name', with: username)
end

When("I enter {string} in the password field") do |password|
    fill_in('password', with: password)
end

Then('error {string} is shown') do |message|
    errorMessage = find('[data-test="error"]', wait: 2).text
    # errorMessage = find(:xpath, '//h3[@data-test="error" or contains(@class, "error-message")]', wait: 2).text
    expect(errorMessage).to eq(message)
    puts "Error message: #{errorMessage}"
end


