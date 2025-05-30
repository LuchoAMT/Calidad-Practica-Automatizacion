Feature: As a BDD student
         I want to test the saucedemo page
         So me and my partner can have 100 points in this practice.

Background:
     Given I browse to the saucedemo page

@errlog
Scenario Outline: Testing login with different credentials in saucedemo site.
    When I enter <username> in the username field
    And I enter <password> in the password field
    And I click on the "Login" button 
    Then error <error_message> is shown

    Examples:
  | username         | password        | error_message                            |
  |""                |""               | "Epic sadface: Username is required"     |
  | "standard_user"  |""               | "Epic sadface: Password is required"     |
  | "locked_out_user"| "secret_sauce"  | "Epic sadface: Sorry, this user has been locked out." |


Scenario: Testing login with correct credentials in saucedemo site.
    When I enter "standard_user" in the username field
    And I enter "secret_sauce" in the password field
    And I click on the Login button 
    Then Products page is shown
    And first item is "Sauce Labs Backpack"


Scenario: Testing the add to cart button in the saucedemo site.
    And I login with correct credentials
    When I am in the Products page
    And I click on the Add to cart button in the first product card
    Then Add to cart button should change to Remove


Scenario: Testing that all products are displayed on the Products page.
    And I login with correct credentials
    When I am in the Products page
    Then I should see 6 product cards displayed


Scenario: Testing the filter function in the prodcuts page in saucedemo site.
    And I login with correct credentials
    When I click on the product sort box
    And I click on "Price (high to low)" option from the product sort box
    Then first item price is 49.99


Scenario: Testing correct cart redirection
    And I login with correct credentials
    And I add a product to the cart
    When I click on the cart icon 
    Then Your Cart page is shown
    And the cart badge should be 1


Scenario: Testing checkout in cart
    And I login with correct credentials
    And I add a product to the cart
    When I click on the cart icon 
    And I click on the "checkout" button
    Then the Checkout: Your Information is shown


Scenario: Testing back to shopping in cart
    And I login with correct credentials
    And I add a product to the cart
    When I click on the cart icon 
    And I click on the "Continue Shopping" button
    Then Products page is shown

@cpp
Scenario: Testing the checkout information when blank
    And I login with correct credentials
    And I add a product to the cart
    And I click on the cart icon 
    And I click on the "checkout" button
    When I click on the "Continue" button 
    Then error "Error: First Name is required" is shown in checkout page

@sus
Scenario: Testing the checkout information when last name and zip code are blank
    And I login with correct credentials
    And I add a product to the cart
    And I click on the cart icon 
    And I click on the "checkout" button
    And I enter "pan" in the First Name field
    When And I click on the "Continue" button 
    Then error "Error: Last Name is required" is shown in checkout page

@zip
Scenario Outline: Testing the checkout information when there's blanks
    And I login with correct credentials
    And I add a product to the cart
    And I click on the cart icon 
    And I click on the "checkout" button
    When I enter "<first_name>" in the First Name field
    And I enter "<last_name>" in the Last Name field
    And I enter "<zipcode>" in the Postal Code
    And I click on the "Continue" button 
    Then error "<error_message>" is shown in checkout page

    Examples:
    | first_name      | last_name     | zipcode       | error_message                   |
    |                 | conqueso    |             | Error: First Name is required |
    | pan           |               |             | Error: Last Name is required  |
    | pan           | conqueso    |             | Error: Postal Code is required|

@cc
Scenario: Testing the checkout information when all data is filled
    And I login with correct credentials
    And I add a product to the cart
    And I click on the cart icon 
    And I click on the "checkout" button
    And I enter "pan" in the First Name field
    And I enter "conqueso" in the Last Name field
    And I enter "0000" in the Postal Code 
    When I click on the "Continue" button 
    Then the Checkout: Overview page is shown

Scenario: Testing the full buying process
    And I login with correct credentials
    And I add a product to the cart
    And I click on the cart icon 
    And click on the "checkout" button.
    And enter "pan" in the First Name field
    And enter "conqueso" in the Last Name field
    And enter 0000 in the Postal Code 
    And I click on the "Continue" button 
    When I click on the Finish button in the overview page
    Then the "Checkout: complete" page is shown.