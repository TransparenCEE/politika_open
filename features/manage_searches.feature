Feature: Search
  In order search for persons
	As a site viewer
	I want to find persons by entering details about them
  
  Scenario: Search for a person
    Given there is person with name "Vojto Rinik"
  	And there is person with name "some bullshit"
    And I am on the new search page
    # And show me the page
    When I fill in "Meno" with "Vojto"
    And I press "Hľadať"
		Then I should be on the user list page
    # And show me the page
		And I should see "Vojto"
		And I should see "Rinik"
		And I should not see "some"
		And I should not see "bullshit"