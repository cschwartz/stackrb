require_relative "../spec_helper"

describe StackRb::Site do
  describe "#find_users" do
    describe "with valid id" do
      let(:user_id) { 806689 }
      subject { StackRb::Site.new "stackoverflow" }
      it "should not return nil" do
        subject.find_users([user_id]).should_not be_nil
      end

      it "should not return invalid users" do
        invalid_user_id = -4
        subject.find_users([invalid_user_id]).should be_empty
      end

      describe "should return as many valid users as specified" do
        it "for 0 ids it should return the last 30 users" do
          empty_set = []
          subject.find_users(empty_set).should have(30).users
        end

        it "for 1 id" do
          user_ids = [user_id]
          subject.find_users(user_ids).should have(1).users
        end

        it "for 2 ids" do
          other_user_id = "12345"
          user_ids = [user_id, other_user_id]
          subject.find_users(user_ids).should have(2).users
        end
      end

    end
  end

end
