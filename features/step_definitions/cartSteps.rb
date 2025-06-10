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


Then("Your Cart page is shown") do
    cartLabel = find(:css, '#header_container > div.header_secondary_container > span').text
    expect(cartLabel).to eq('Your Cart')
    expect(page).to have_current_path('/cart.html')
    puts "Your Cart page is displayed"
    puts "Current path: #{page.current_path}"
end #Separar el coso en 2, uno para el label y otro para el path?