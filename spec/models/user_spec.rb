# -*- encoding : utf-8 -*-
require 'spec_helper'
require 'digest/sha1'

describe User, "basic features" do
  
  # FIXME: use ddatabasecleaner for this
  before { User.destroy_all }
  
  let(:init_sample_user) { User.new(email: "some@email.com", password: 'blah', password_confirmation: 'blah') }
  let(:valid_user) do
    init_sample_user.basic_information_first_name = 'first_name'
    init_sample_user.basic_information_last_name = 'last_name'
    init_sample_user.basic_information_date_of_birth = '1.1.2000'
    init_sample_user.telephone_number = '123456'
    init_sample_user.is_politician = true
    init_sample_user
  end
  
  describe 'initialization' do
    subject { init_sample_user }
    
    it { should_not be_nil }
    its(:email) { should == "some@email.com"}
    its(:password) { should == 'blah' }
    its(:password_confirmation) { should = 'blah' }
    its(:save) { should == false}
  end
  
  describe 'validation' do
    subject { init_sample_user }
    
    it "should save with everything valid" do
      valid_user.should be_valid
    end
    
    it "should not save when password don't match" do
      valid_user.password_confirmation = "some bullshit"
      
      valid_user.should be_invalid
    end
    
    describe "password encoding" do
      it "should encode password after saving" do
        valid_user.save
        valid_user.password.should == Digest::SHA1.hexdigest("blah")
      end
      
      it "should not encode password twice when saving twice" do
        valid_user.save
        valid_user.save
        valid_user.password.should == Digest::SHA1.hexdigest("blah")
      end
    end

  end
  
  describe 'authentication' do
    it 'should not authenticate a user that is not in the db' do
      User.authenticate("test@test.com", "test").should == false
    end
  
    it "should authenticate by email and password" do
      password = valid_user.password
      email = valid_user.email
      valid_user.save
      User.authenticate(email, password).should == valid_user
    end
  end
end
