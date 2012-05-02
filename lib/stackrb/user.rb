module StackRb
  class User
    include StackRb
    property :about_me
    property :accept_rate
    property :account_id
    property :age
    property :answer_count
    property :badge_counts do |badge_json|
      ::StackRb::Badges.new badge_json
    end
    property :creation_date do |timestamp|
      Time.at timestamp
    end
    property :display_name
    property :down_vote_count
    property :is_employee
    property :last_access_date do |timestamp|
      Time.at timestamp
    end  
    property :last_modified_date do |timestamp|
      Time.at timestamp
    end  
    property :link
    property :location
    property :profile_image
    property :question_count
    property :reputation
    property :reputation_change_day
    property :reputation_change_week
    property :reputation_change_month
    property :reputation_change_quarter
    property :reputation_change_year
    property :timed_penalty_date do |timestam|
       Time.at timestamp
    end
    property :user_id
    property :user_type
    property :view_count
    property :website_url

    def initialize(user_json)
      fill_properties(user_json)
    end

    class << self
      def find(ids, options = {})
        fetch User, "/users/%{user_list}", {:user_list => ids}, :site => default_site
      end

      def default_site
        default_site = "stackoverflow"
      end
    end

  end
end
