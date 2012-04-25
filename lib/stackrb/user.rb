require "httparty"
require "json"

module StackRb
  class User
    include HTTParty
    base_uri "http://api.stackexchange.com/2.0"

    attr_reader :display_name, :reputation

    def initialize(user_json)
      @display_name = user_json["display_name"]
      @reputation = user_json["reputation"]
    end
 
    class << self
      def find(ids, options = {})
        options[:site] ||= default_site
        ids_string = ids.join ";"
        body = get("/users/#{ ids_string }", :query => options)
        users_json = JSON.parse body
        
        users_json["items"].map { |user_json| User.new user_json }
      end

      def default_site
        default_site = "stackoverflow"
      end

  end    
    
  end
end
