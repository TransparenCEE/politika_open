# -*- encoding : utf-8 -*-
Then /^I should see the following searches:$/ do |expected_searches_table|
  expected_searches_table.diff!(tableish('table tr', 'td,th'))
end

Given /^there are no persons$/ do
  User.delete_all
end

Given /^there is person with name "([^\"]*)"$/ do |name|
  first_name, last_name = name.split(' ')
  create_person(first_name, last_name)
end

def create_person(first_name, last_name)
  person = User.new(:basic_information_first_name => first_name,
                      :basic_information_last_name => last_name,
                      :is_active => true)
  person.should_receive(:count_invalid_fields).and_return(0)
  person.save(false)
end
