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

    describe "should support types like" do
      it "Time" do
        class TestClass
          include StackRb::StackRb

          property :test_date do |timestamp| Time.at timestamp end
          
          def initialize(hash)
            fill_properties(hash)
          end

        end

        hash = { :test_date => 1295002457 }
        instance = TestClass.new hash
        instance.test_date.should == Time.at(hash[:test_date])
      end
    end
    
  end
  
end
