# -*- encoding : utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'digest/sha1'

describe User, "basic features" do
  
  before :each do
    User.destroy_all
  end
  
  def init_sample_user
    user = User.new
    user.email = "some@email.com"
    user.password = "blah"
    user.password_confirmation = "blah"
    user
  end
  
  it "should initialize new model" do
    user = User.new
  end
  
  it "should initialize new model and have fields working" do
    user = User.new
    user.email
    user.password
    user.email = "some@email.com"
    user.password = "blahblah"
    user.password_confirmation = "blahblah"
  end
  
  it "should not save when not valid" do
    user = User.new
    user.save.should == false
  end
  
  it "should not save when password don't match" do
    user = init_sample_user
    user.password_confirmation = "some bullshit"
    user.should_not be_valid
    user.save.should == false
  end
  
  it "should save with everything valid" do
    user = init_sample_user
    user.save.should == true
  end
  
  describe "password encoding" do
    it "should encode password after saving" do
      user = init_sample_user
      user.password.should == "blah"
      user.save
      user.password.should == Digest::SHA1.hexdigest("blah")
    end
    
    it "should not encode password twice when saving twice" do
      user = init_sample_user
      user.password.should == "blah"
      user.save
      user.save
      user.password.should == Digest::SHA1.hexdigest("blah")
    end
  end
  
  it "should authenticate by email and password" do
    User.authenticate("test@test.com", "test").should == false
    user = User.create!(:email => "test@test.com", :password => "test", :password_confirmation => "test")
    User.authenticate("test@test.com", "test").should == user
  end
end

describe User, "updating" do
  it "should set basic information" do
    @user = User.new
    @user.write_attributes({:basic_information => {:name => "Vojto"}})
    @user.save(false)
    # @user.basic_information = {:name => "Vojto"}
    # @user.save
    @user.basic_information.should_not be_nil
    @user.basic_information[:name].should == "Vojto"
  end
end

describe User, "attributes" do
  it "should read value" do
    @user = User.new
    @user.write_attributes({:basic_information_name => "Vojto"})
    @user.save(false)
    @user.value(:basic_information, :name).should == "Vojto"
  end
    
  it "should parse boolean value" do
    @user = User.new
    @user.write_attributes({:basic_information_is_interesting => "1"})
    @user.save(false)
    @user.boolean_value(:basic_information, :is_interesting).should == true
    
    @user.basic_information_is_interesting = "0"
    @user.boolean_value(:basic_information, :is_interesting).should == false
    
    @user.basic_information_is_interesting = ""
    @user.boolean_value(:basic_information, :is_interesting).should == false
  end
end
