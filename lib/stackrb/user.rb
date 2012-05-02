module StackRb
  class User
    include StackRb
    property :reputation
    property :display_name
    property :creation_date do |timestamp|
      Time.at timestamp
    end

    def initialize(user_json)
      fill_properties(user_json)
    end

    class << self
      def find(ids, options = {})
      end

      def default_site
        default_site = "stackoverflow"
      end
    end

  end
end
