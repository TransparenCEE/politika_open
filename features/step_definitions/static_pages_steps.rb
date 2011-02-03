# -*- encoding : utf-8 -*-
Given /^there is a page called "([^\"]*)" with contents "([^\"]*)"$/ do |name, contents|
  path = "#{Rails.root}/app/pages/#{name}.html"
  File.delete(path) if File.exists?(path)
  File.open(path, "w") do |f|
    f.write(contents)
  end
end
