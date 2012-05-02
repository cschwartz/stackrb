module StackRb
	class Site
    include StackRb

    def initialize(site_name, options = {})
      @site_name = site_name
		end

		def find_users(user_list)
      Site.fetch User, "/users/%{user_list}", {:user_list => user_list}, :site => @site_name
		end
	end
end
