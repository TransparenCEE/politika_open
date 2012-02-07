When /^I request a password reset$/ do
  visit new_session_path
  find("//a[@rel='reset-password']").click
  fill_in('email', with: 'Arthur.Dent@example.com')
  click_button 'reset_password_commit'
end

Then /^the password should be reset and I should get an email with the new one$/ do
  page.should have_xpath("//div[@id='flash']")
  ActionMailer::Base.deliveries.should be_present
end

Then /^I should be able to login with the new password$/ do
  new_password = ActionMailer::Base.deliveries.first.body.match(/Heslo:\s+(.*)</)[1]
  visit new_session_path
  fill_in('email', with: 'Arthur.Dent@example.com')
  fill_in('password', with: new_password)
  click_button 'login_commit'
  URI.parse(current_url).path.should == user_path(User.first)
end