require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Forms::Field do
  
  describe "#new" do
    it "should not create new field without identifier" do
      lambda {
        field = Forms::Field.new
      }.should raise_error
    end
  
    it "should create new field" do
      field = Forms::Field.new(:new_awesome_field)
      field.should be_instance_of(Forms::Field)
      field.identifier.should == "new_awesome_field"
    end
  
    it "should create new field with settings" do
      field = Forms::Field.new(:new_awesome_field, {:some => "awesome_settings"})
      field.should be_instance_of(Forms::Field)
      field.identifier.should == "new_awesome_field"
      field.settings.should == {:some => "awesome_settings"}
    end
    
    it "should convert text keys in options into symbols" do
      field = Forms::Field.new(:test, {"text_option" => "some_value"})
      field.settings[:text_option].should == "some_value"
    end
  end
  
  describe ".title" do
    it "should return title of field if specified" do
      field = Forms::Field.new(:new_awesome_field, {:title => "Awesome!!!"})
      field.title.should == "Awesome!!!"
    end
  
    it "should return humanized identifier if no field is specified" do
      field = Forms::Field.new(:new_awesome_field)
      field.title.should == "New awesome field"
    end
  end
  
  describe ".is_required?" do
    before do
      @field = Forms::Field.new(:test_field)
    end
    
    context "when settings[:required] = true" do
      it "should be required" do
        @field.settings[:required] = "true"
        @field.should be_required
      end
    end
    
    context "when settings[:required] = 1" do
      it "should be required" do
        @field.settings[:required] = "1"
        @field.should be_required
      end
    end
    
    context "when settings[:required] = false" do
      it "should not be required" do
        @field.settings[:required] = "false"
        @field.should_not be_required
      end
    end
    
    context "when settings[:required] = 0" do
      it "should not be required" do
        @field.settings[:required] = "0"
        @field.should_not be_required
      end
    end
    
    context "when settings[:required] is nil" do
      it "should not be required" do
        @field.settings[:required] = nil
        @field.should_not be_required
      end
    end
  end
  
  describe  ".has_errors?"
    context "when has errors" do
      
    end
    
    context "when has to errors" do
      
    end
  end
end