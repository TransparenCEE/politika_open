Feature: Static Pages
	In order to see interesting information about FPA
	As a site viewer
	I want to see pages about FPA
	
	Scenario: View a page
	Given there is a page called "about_us" with contents "Hello World"
	And I go to the About Us page
	Then I should see "Hello World"