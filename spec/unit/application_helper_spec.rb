# -*- encoding : utf-8 -*-
require 'spec_helper'

describe ApplicationHelper do

  include ApplicationHelper
  
  describe '#uploaded_image' do
    it 'returns path to uploaded image' do
      self.should_receive(:image_tag).with('/uploads/my_image').and_return('path')
      uploaded_image('my_image').should == 'path'
    end

    it 'returns path to placeholder image' do
      self.stub(:image_tag).with('photo-placeholder.png').and_return('placeholder-path')
      uploaded_image(nil).should == 'placeholder-path'
      uploaded_image('').should == 'placeholder-path'
    end
  end

end
