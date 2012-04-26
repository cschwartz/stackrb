module StackRb
  module StackRb
    def self.included(base)
      base.extend ClassMethods
    end

    def fill_properties(hash)
      hash.each do |k, v|
        self.instance_variable_set "@#{k}", v
      end
    end
    
    module ClassMethods
      def property(name)
        attr_reader name
      end
    end
  end
end
