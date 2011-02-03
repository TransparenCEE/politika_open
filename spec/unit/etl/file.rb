# -*- encoding : utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

class Etl::Rules::MyEntity < Etl::Rule; end

module Etl
  describe File do
    describe "initializing" do
      before :each do
        @entity = Etl::File.new('/just/some/awesome/path/my_entity.csv')
      end
      
      it "should find entity name from file path" do
        @entity.name.should == 'my_entity'
      end
      
      it "should set up new rule for type" do
        @entity.rule.should be_kind_of(Etl::Rules::MyEntity)
      end
    end
  end
end
