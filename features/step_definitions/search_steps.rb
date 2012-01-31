# -*- encoding : utf-8 -*-
Then /^I should see the following searches:$/ do |expected_searches_table|
  expected_searches_table.diff!(tableish('table tr', 'td,th'))
end

Given /^there is person with name "([^\"]*)"$/ do |name|
  first_name, last_name = name.split(' ')
  create_person(first_name, last_name)
end

def create_person(first_name, last_name)
  user = User.create!( basic_information_first_name: first_name,
                basic_information_last_name: last_name,
                is_active: true,
                basic_information_date_of_birth: '1.1.2000',
                telephone_number: '123456',
                is_politician: true,
                email: "#{first_name}.#{last_name}@email.com", 
                password: 'blah', 
                password_confirmation: 'blah',
                count_of_invalid_fields: 0
              )
end

Given 'the Sphinx indexes are updated' do
  # Update all indexes
  ThinkingSphinx::Test.index
  sleep(0.25) # Wait for Sphinx to catch up
end

Given 'the Sphinx indexes for articles are updated' do
  # Update specific indexes
  ThinkingSphinx::Test.index 'article_core', 'article_delta'
  sleep(0.25) # Wait for Sphinx to catch up
end