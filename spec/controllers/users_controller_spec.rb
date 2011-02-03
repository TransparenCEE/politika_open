# -*- encoding : utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UsersController, "creating account" do
  
  it "should show form" do
    get :new
    response.should render_template(:new)
  end
  
  it "should create new account, log it in and redirect to forms list" do
    @user = mock("user")
    @user.stubs(:id).returns("user_id")
    @user.expects(:save).returns(true)
    @user.stubs(:model_name).returns("user")
    
    User.expects(:new).returns(@user)
    
    post :create, :user => {:email => "test@test.com"}
    session[:current_user].should == "user_id"
    response.should redirect_to forms_path
  end
  
  it "should update user" do
    
  end
  
end
