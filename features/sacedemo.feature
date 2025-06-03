Feature: As a BDD student
         I want to test the saucedemo page
         So me and my partner can have 100 points in this practice.

Background:
     Given I browse to the saucedemo page
     And I login with correct credentials
     When I am in the Products page

@cart
Scenario: Testing the add to cart button in the saucedemo site.
    
    And I click on the Add to cart button in the first product card
    Then Add to cart button should change to Remove


@products
Scenario: Testing the filter function in the prodcuts page in saucedemo site.
   
    And I click on the product sort box
    And I click on "Price (high to low)" option from the product sort box
    Then I should see the following products with prices in order:
        | Product                           | Price  |
        | Sauce Labs Fleece Jacket          | 49.99  |
        | Sauce Labs Backpack               | 29.99  |
        | Sauce Labs Bolt T-Shirt           | 15.99  |
        | Test.allTheThings() T-Shirt (Red) | 15.99  |
        | Sauce Labs Bike Light             |  9.99  |
        | Sauce Labs Onesie                 |  7.99  |

@products
Scenario: Testing the filter function in the prodcuts page in saucedemo site.
   
    And I click on the product sort box
    And I click on "Name (A to Z)" option from the product sort box
    Then I should see the following products with prices in order:
        | Product                           | Price  |
        | Sauce Labs Backpack               | 29.99  |
        | Sauce Labs Bike Light             |  9.99  |
        | Sauce Labs Bolt T-Shirt           | 15.99  |
        | Sauce Labs Fleece Jacket          | 49.99  |
        | Sauce Labs Onesie                 |  7.99  |
        | Test.allTheThings() T-Shirt (Red) | 15.99  |

@cart
Scenario: Testing correct cart redirection
    And I click on the Add to cart button in the first product card
    When I click on the cart icon 
    Then Your Cart page is shown
    And the cart badge should be 1
    And I should see the following data:
        | QTY | Product                    | Price |
        |  1  | Sauce Labs Backpack        | 29.99 |

@cart
Scenario: Testing checkout in cart
    And I click on the Add to cart button in the first product card
    When I click on the cart icon 
    And I click on the "checkout" button
    Then the Checkout: Your Information is shown


Scenario: Testing back to shopping in cart
    And I click on the Add to cart button in the first product card
    When I click on the cart icon 
    And I click on the "Continue Shopping" button
    Then Products page is shown
    And I should see the following products:
        | Product Name               |
        | Sauce Labs Backpack        |
        | Sauce Labs Bike Light      |
        | Sauce Labs Bolt T-Shirt    |
        | Sauce Labs Fleece Jacket   |
        | Sauce Labs Onesie          |
        | Test.allTheThings() T-Shirt (Red) |



@zip
Scenario Outline: Testing the checkout information when there's blanks
    And I click on the Add to cart button in the first product card
    And I click on the cart icon 
    And I click on the "checkout" button
    When I enter "<first_name>" in the First Name field
    And I enter "<last_name>" in the Last Name field
    And I enter "<zipcode>" in the Postal Code
    And I click on the "Continue" button 
    Then error "<error_message>" is shown in checkout page

    Examples:
    | first_name      | last_name     | zipcode       | error_message                 |
    |                 |               |               | Error: First Name is required |
    |                 | conqueso      |               | Error: First Name is required |
    | pan             |               |               | Error: Last Name is required  |
    | pan             | conqueso      |               | Error: Postal Code is required|


@sus
Scenario: Testing the checkout information when all data is filled
    And I click on the Add to cart button in the first product card
    And I click on the cart icon 
    And I click on the "checkout" button
    And I enter "pan" in the First Name field
    And I enter "conqueso" in the Last Name field
    And I enter "0000" in the Postal Code 
    When I click on the "Continue" button 
    Then the Checkout: Overview page is shown
    And the following data is displayed:
        | QTY | Product                    | Price | Tax   | Total |
        |  1  | Sauce Labs Backpack        | 29.99 | 2.40  | 32.39 |
    


@cc
Scenario: Testing the full buying process
    And I click on the Add to cart button in the first product card
    And I click on the cart icon 
    And I click on the "checkout" button
    And I fill the checkout form with correct data
    And I click on the "Continue" button 
    When I click on the "finish" button
    Then the Checkout: Complete page is shown

Scenario: Testing the menu button
    When I click on the burguer menu button
    Then I should see the following options:
        | Options                 |
        | All Items               |
        | About                   |
        | Logout                  |
        | Reset App State         |
@XD
Scenario: Testing the menu button
    When I click on the burguer menu button
    And I click on the "About" option
    Then I should see the text "Build apps users love with AI-driven insights"
@XD
Scenario: Testing the menu button
    When I click on the burguer menu button
    And I click on the "Logout" option
    Then I should see the text "Swag Labs"