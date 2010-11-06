require 'spec_helper'

describe SessionsController do

  describe "GET new" do
    it "show form or something" do
      get :new
      response.should be_success
    end
  end

  describe "POST create" do

    it "should log user in" do
      user = mock
      User.stub(:authenticate).and_return(user)
      User.should_receive(:authenticate).with("test@user.com", "some_password")
      
      post :create, :email => "test@user.com", :password => "some_password"
      
      session[:current_user].should == user.id
      response.should redirect_to(forms_path)
    end

  end

end
