Feature: As a BDD student
         I want to test the saucedemo page's checkout process
         So me and my partner can have 100 points in this practice.

  Background:
    Given I browse to the saucedemo page
    And I login with correct credentials
    When I am in the Products page
    And I click on the Add to cart button for the following products:
      | Product Name        |
      | Sauce Labs Backpack |
    And I click on the cart icon
    And I click on the "checkout" button

  @zip
  Scenario Outline: Testing the checkout information when there's blanks
    When I enter "<first_name>" in the First Name field
    And I enter "<last_name>" in the Last Name field
    And I enter "<zipcode>" in the Postal Code
    And I click on the "Continue" button
    Then error "<error_message>" is shown in checkout page

    Examples:
      | first_name | last_name | zipcode | error_message                  |
      |            |           |         | Error: First Name is required  |
      |            | conqueso  |         | Error: First Name is required  |
      | pan        |           |         | Error: Last Name is required   |
      | pan        | conqueso  |         | Error: Postal Code is required |

  @sus
  Scenario: Testing the checkout information when all data is filled
    And I enter "pan" in the First Name field
    And I enter "conqueso" in the Last Name field
    And I enter "0000" in the Postal Code
    When I click on the "Continue" button
    Then the Checkout: Overview page is shown
    And the following data is displayed:
      | QTY | Product             | Price |
      |   1 | Sauce Labs Backpack | 29.99 |
    And the tax should be correctly calculated as 2.40
    And the total should be correctly calculated as 32.39

  @cc
  Scenario: Testing the full buying process
    And I fill the checkout form with the following data:
      | field       | value |
      | first name  | Jane  |
      | last name   | Doe   |
      | postal code | 12345 |
    And I click on the "Continue" button
    When I click on the "finish" button
    Then the Checkout: Complete page is shown
