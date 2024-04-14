@Regression
Feature: Valid Login

  Background:
    Given user is on login page

  Scenario Outline: Successful login with valid credentials
    When user login as "<User_Role>"
#    Then User should be redirected to the inventory page

    Examples:
      | User_Role |
      | admin     |
