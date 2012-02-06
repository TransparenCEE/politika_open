Feature: password reset

  In order to be able to reset their password
  A registered user
  Should be able to reset their password
  
  Scenario: reset password via email
    Given there is person with name "Arthur Dent"
    When I request a password reset
    Then the password should be reset and I should get an email with the new one
    And I should be able to login with the new password