require_relative "../spec_helper.rb"

describe StackRb::User do
  describe "#initialize" do
    let(:params) { 
      input_file = File.open "spec/responses/valid_user_by_id.json"
      json = JSON.parse(input_file.read, :symbolize_names => true)
      json[:items].first
    }

    subject {
      StackRb::User.new params
    }

    it "should have the correct display name" do
      subject.display_name.should == params[:display_name]
    end

    it "should have the correct reputation" do
      subject.reputation.should == params[:reputation]
    end

    it "should have the correct creation date" do
      subject.creation_date.should == Time.at(params[:creation_date])
    end
  end
end
