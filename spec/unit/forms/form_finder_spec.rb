# -*- encoding : utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

module Forms
  describe FormFinder do
    before :all do
      Config.instance.forms_directory = "#{Rails.root}/spec/fixtures/forms"
    end
    
    describe "returning instance" do
      it "should return an instance" do
        raise Config.instance.forms_directory
        FormFinder.instance.should be_instance_of FormFinder
      end
    end
    
    describe "finding forms for class" do
      before :each do
        @finder = FormFinder.instance
      end
      
      it "should find forms for User" do
        forms = @finder.forms_for(User)
        forms.should be_kind_of(Array)
        forms.size.should == 2
      end
    end
  end
end
