require "pry"

module StackRb
  module StackRb
    def self.included(base)
      base.extend ClassMethods
      identity_function = Proc.new do |v|
          v
      end
      base.instance_variable_set "@converters", Hash.new(identity_function)
    end

    def fill_properties(hash)
      hash.each do |k, v|
        self.class.convert_variable(self, k, v)
      end
    end
    
    module ClassMethods
      def property(name, options = {}, &block)
        attr_reader name
        if block
          @converters[name] = block
        end
      end

      def convert_variable(instance, name, value)
        value = @converters[name].call(value)
        instance.instance_variable_set "@#{name}", value
      end
    end
  end
end
