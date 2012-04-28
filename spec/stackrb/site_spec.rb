require_relative "../spec_helper"

describe StackRb::Site do
	it "should call UserObtainer with a correct 'site' parameter" do
		UserObtainer = double("UserObtainer")
		UserObtainer.should_receive(:new).with(:site => "stackoverflow")
		StackRb::Site.new "stackoverflow", :user_obtainer => UserObtainer
	end

	describe "#find_users" do
		it "should delegate to the UserObtainer#find" do
			user_obtainer_instance = double("UserObtainer")
			user_obtainer_instance.should_receive(:find).with([12345])
			user_obtainer_klass = double("UserObtainer.class")
			user_obtainer_klass.stub(:new).and_return(user_obtainer_instance)
			site = StackRb::Site.new "stackoverflow", :user_obtainer => user_obtainer_klass
			site.find_users([12345])
		end

		it "should return the results returned by UserObtainer#find" do
			user_list = []
			user_obtainer_instance = double("UserObtainer")
			user_obtainer_instance.should_receive(:find).and_return(user_list)
			user_obtainer_klass = double("UserObtainer.class")
			user_obtainer_klass.stub(:new).and_return(user_obtainer_instance)
			site = StackRb::Site.new "stackoverflow", :user_obtainer => user_obtainer_klass
			site.find_users([12345]).should == user_list
		end
	end
end
