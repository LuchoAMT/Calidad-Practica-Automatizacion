Feature: As a BDD team 
         We want to test the login form of saucedemo
         So we can validate the login form is working correctly

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

@tab
Scenario: Testing login with correct credentials in saucedemo site.
    When I enter "standard_user" in the username field
    And I enter "secret_sauce" in the password field
    And I click on the "Login" button 
    Then Products page is shown
    And I should see the following products:
        | Product Name               |
        | Sauce Labs Backpack        |
        | Sauce Labs Bike Light      |
        | Sauce Labs Bolt T-Shirt    |
        | Sauce Labs Fleece Jacket   |
        | Sauce Labs Onesie          |
        | Test.allTheThings() T-Shirt (Red) |