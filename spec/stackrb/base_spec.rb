require_relative "../spec_helper"
require "httparty"
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


  describe "#fetch" do
    describe "should GET data from the requested url" do
      it "with the correct base url" do
        source_url = "/tests"
        full_url = "http://api.stackexchange.com/2.0#{source_url}" 
        FakeWeb.register_uri :get, full_url, :body => '{"items": []}' 
        class RESTObject  
          include StackRb::StackRb
        end
        RESTObject.fetch Object, source_url
        FakeWeb.should have_requested(:get, full_url)
      end
    end

    it "should initialize the class given as many times as 'item' members are present in the file specified by the uri" do
      source_url = "/tests"
      json_content = '{"items": [{}, {}]}'
      MyClass = double("MyClass")
      MyClass.should_receive(:new)
      MyClass.should_receive(:new)
      FakeWeb.register_uri :get, "http://api.stackexchange.com/2.0#{source_url}", :body => json_content
      class RESTClass
        include StackRb::StackRb
      end
      RESTClass.fetch MyClass, source_url
    end

    it "should correctly place arguments" do
      source_url = "/tests/%{user_ids}"
      user_ids = [123, 456]
      full_url = "http://api.stackexchange.com/2.0#{source_url}" % {:user_ids => user_ids.join(";")}
      json_content = '{"items": [{}, {}]}'
      FakeWeb.register_uri :get, full_url, :body => json_content
      class RESTClass
        include StackRb::StackRb
      end
      class RESTInstance
        def initialize(params)

        end
      end

      RESTClass.fetch RESTInstance, source_url, :user_ids => user_ids
      FakeWeb.should have_requested(:get, full_url)
    end
  end
end
