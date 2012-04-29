require_relative "../spec_helper.rb"

describe StackRb::User do
  describe "#find" do
    describe "with valid id" do
      let(:user_id) { 806689 }
      
      it "should not return nil" do
        StackRb::User.find([user_id]).should_not be_nil
      end

      it "should not return invalid users" do
        invalid_user_id = -4
        StackRb::User.find([invalid_user_id]).should be_empty
      end
            
      describe "should return as many valid users as specified" do
        it "for 0 ids it should return the last 30 users" do
          empty_set = []
          StackRb::User.find(empty_set).should have(30).users
        end

        it "for 1 id" do
          user_ids = [user_id]
          StackRb::User.find(user_ids).should have(1).users
        end

        it "for 2 ids" do
          other_user_id = "12345"
          user_ids = [user_id, other_user_id]
          StackRb::User.find(user_ids).should have(2).users
        end
      end

      it "should have the correct display name" do
        display_name = "Christian Schwartz"
        StackRb::User.find([user_id]).first.display_name.should == display_name
      end

      it "should have the correct reputation" do
        reputation = 311
        StackRb::User.find([user_id]).first.reputation.should == reputation
      end

      it "should have the correct creation date" do
        creation_date = Time.at 1295002457
        StackRb::User.find([user_id]).first.creation_date.should == creation_date
      end
    end
  end
  
end
