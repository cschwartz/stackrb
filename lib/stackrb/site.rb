module StackRb
	class Site
		def initialize(site_name, options = {})
			user_obtainer_klass = options[:user_obtainer]
			@user_obtainer = user_obtainer_klass.new :site => site_name
		end

		def find_users(user_id_list)
			@user_obtainer.find(user_id_list)	
		end
	end
end
