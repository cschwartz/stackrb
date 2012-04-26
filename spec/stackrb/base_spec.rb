require_relative "../spec_helper"

describe StackRb::StackRb do
  describe "#property" do
    it "should add an attr_reader for the given property" do
      class TestClass
        include StackRb::StackRb

        property :test
      end

      instance = TestClass.new
      instance.public_methods.should include :test
    end

    it "should declare readable properties from a passed hash" do
      class TestClass
        include StackRb::StackRb

        def initialize(hash)
          fill_properties(hash)
        end

        
        property :test
      end

      hash = { :test => "Value" }
      instance = TestClass.new hash
      instance.test.should == "Value"
    end
  end
  
end
