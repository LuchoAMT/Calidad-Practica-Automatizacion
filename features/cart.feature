Feature: As a BDD student
         I want to test the saucedemo cart funtions
         So me and my partner can have 100 points in this practice.

Background:
     Given I browse to the saucedemo page
     And I login with correct credentials
     When I am in the Products page


@cart
Scenario: Testing correct cart redirection
    And I click on the Add to cart button for the following products:
        | Product Name               |
        | Sauce Labs Backpack        |
        | Sauce Labs Bike Light      |
        | Sauce Labs Bolt T-Shirt    |
    When I click on the cart icon 
    Then Your Cart page is shown
    And the cart badge should be 3
    And I should see the following data:
        | QTY | Product                    | Price |
        |  1  | Sauce Labs Backpack        | 29.99 |
        |  1  | Sauce Labs Bike Light      |  9.99 |
        |  1  | Sauce Labs Bolt T-Shirt    | 15.99 |

@cart
Scenario: Testing checkout in cart
    And I click on the Add to cart button for the following products:
        | Product Name               |
        | Sauce Labs Backpack        |
        | Sauce Labs Bike Light      |
        | Sauce Labs Bolt T-Shirt    |
    When I click on the cart icon 
    And I click on the "checkout" button
    Then the Checkout: Your Information is shown

@cart
Scenario: Testing back to shopping in cart
    And I click on the Add to cart button for the following products:
        | Product Name               |
        | Sauce Labs Backpack        |
        | Sauce Labs Bike Light      |
        | Sauce Labs Bolt T-Shirt    |
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
