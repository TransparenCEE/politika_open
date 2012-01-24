# -*- encoding : utf-8 -*-
require 'spec_helper'

describe SessionsController do

  describe "GET new" do
    it "show form or something" do
      get :new
      response.should be_success
    end
  end

  describe "POST create" do
    let(:user) { stub('user') }

    it "should log user in" do
      User.should_receive(:authenticate).with("test@user.com", "some_password").and_return(user)
      controller.should_receive(:log_in!).with(user)
      
      post :create, :email => "test@user.com", :password => "some_password"
      response.should redirect_to(user_path(user))
    end

  end

end
