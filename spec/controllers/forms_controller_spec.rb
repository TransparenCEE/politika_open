# -*- encoding : utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe FormsController do
  
  describe "listing" do
    before :all do
      # Login some default user
      @user = User.create(:email => "test@test.com", :password => "test", :password_confirmation => "test")
    end

    it "should show all forms for user" do
      get :index
      response.should be_success
      assigns(:finder).should be_instance_of(Forms::FormFinder)
      assigns(:forms).should be_instance_of(Array)
      assigns(:forms).each do |form|
        form.should be_instance_of Forms::Form
      end
    end
  end
  
  describe "showing" do
    it "should load some form" do
      mock_finder = mock('form_finder')
      mock_form   = mock('form')
      mock_form.stubs(:title).returns("mock form title")

      mock_finder.expects(:find_by_identifier).with("some_form").returns(mock_form)
      
      Forms::FormFinder.stubs(:finder_with_file).returns(mock_finder)
      
      get :show, :id => "some_form"
      
      assigns(:form).should == mock_form
      assigns(:user).should be_instance_of(User)
    end
  end
  
end
