# -*- encoding : utf-8 -*-
require 'spec_helper'

describe FormsController do
  let(:visible_forms) { stub('visible_forms') }
  let(:current_user) { stub(visible_forms: visible_forms)}
  before { controller.stub(:current_user).and_return(current_user) }
  
  describe "listing" do
    it "should show all forms for user" do
      get :index
      assigns(:all_forms).should == visible_forms
    end
  end
  
  describe "showing" do
    it "should load some form" do
      mock_finder = mock('form_finder')
      mock_form   = mock('form')
      controller.stub(:find_form).and_return(mock_form)
      
      get :show, :id => "some_form"
      assigns(:form).should == mock_form
      assigns(:user).should == current_user
    end
  end
  
end
