require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require_relative '../lib/clfu.rb'

describe "ClfuRuby" do
  it "can get a response with matching" do
   response = Clfu.matching("ssh")
   response.should_not be_nil 
  end

  it "can get a response with top" do
   response = Clfu.top
   response.should_not be_nil
  end

  it "returns an array of 25 entries with top" do
    response = Clfu.top
    response.size.should == 25
  end

  it "can get a page other than page 0" do
    response = Clfu.top(1)
    response.size.should == 25
  end
end
