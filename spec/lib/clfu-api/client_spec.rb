require "spec_helper"

describe Clfu::API::Client do
  
  before do
    @client = Clfu::API::Client.new
  end

  subject { @client }
  
  describe "#initialize" do
    
    it { should be_an_instance_of(Clfu::API::Client) }

  end

  describe "#matching" do
    
    it { should respond_to(:matching) }

    it "retrieves a basic match" do
      @client.matching("ssh").should_not be_nil
    end

    it "retrives a match with more than 0 entries" do
      @client.matching("grep").size.should > 0
    end

    it "retrieves the second page of a match" do
      @client.matching("find", 1).should_not be_nil
    end
  end

  describe "#top" do

    it { should respond_to(:top) }

    it "retrieves the top commands" do
      @client.top.size.should > 0
    end

    it "retrieves exactly 25 commands per page" do
      @client.top.size.should == 25
    end

    it "retrieves the second page" do
      @client.top(1).size.should > 0
    end

  end

  describe "#last_week" do

    it { should respond_to(:last_week) }

  end
end
