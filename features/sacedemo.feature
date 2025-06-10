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