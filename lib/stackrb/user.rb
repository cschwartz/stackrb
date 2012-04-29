require "httparty"
require "json"

module StackRb
  class User
    include StackRb
    include HTTParty
    base_uri "http://api.stackexchange.com/2.0"

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
        fetch User, "/users/%{user_list}", {:user_list => ids}, :site => default_site
      end

      def default_site
        default_site = "stackoverflow"
      end
    end

  end
end
