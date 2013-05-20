require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require_relative '../lib/clfu.rb'

describe "ClfuRuby" do
  it "can get a response from commandlinefu.com" do
   response = Clfu.matching("ssh")
   response.should_not be_nil 
  end
end
