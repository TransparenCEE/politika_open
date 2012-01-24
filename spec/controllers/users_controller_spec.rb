# -*- encoding : utf-8 -*-
require 'spec_helper'

describe UsersController, "creating account" do
  
  it "should show form" do
    get :new
    response.should render_template(:new)
  end
  
  it "should create new account, log it in and redirect to forms list" do
    NotificationMailer.stub(:user_update).and_return(stub(deliver: true))
    user = mock_model(User, id: 'user_id', save: true, model_name: 'user')
    user.stub(:is_active=)
    
    User.should_receive(:new).and_return(user)
    
    post :create, :user => {:email => "test@test.com"}
    session[:current_user].should == "user_id"
    response.should redirect_to user_path(user)
  end
  
  it "should update user" do
    
  end
  
end
