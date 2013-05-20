require "spec_helper"

describe Clfu::API::Client do
  
  before do
    @client = Clfu::API::Client.new
  end
  
  describe "#initialize" do
    
    it "should instantiate without blowing up" do
      @client.should be_an_instance_of(Clfu::API::Client)
    end

  end

  describe "#top" do

    it "retrieves the top commands" do
      @client.top.size.should > 0
    end

    it "retrieves exactly 25 commands per page" do
      @client.top.size.should == 25
    end

  end
end
