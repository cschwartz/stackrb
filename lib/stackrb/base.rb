require "pry"
require "httparty"
require "json"

module StackRb
  module StackRb
    def self.included(base)
      base.extend ClassMethods
      base.extend HTTParty
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

      def fetch(klass, uri, parameters = {}, query = {})
        query = nil if query.empty?
        base_uri = "http://api.stackexchange.com/2.0"
        options = { :base_uri => base_uri,
          :query => query
        }
        path = (uri % prepare_arguments(parameters))
        response = HTTParty.get path, options
        json = JSON.parse response, :symbolize_names => true
        json[:items].map { |params| klass.new params }
      end

      def convert_variable(instance, name, value)
        value = @converters[name].call(value)
        instance.instance_variable_set "@#{name}", value
      end
      
      def prepare_arguments(parameters)
        parameters.each_with_object({}) { |(name, values), hash|
          hash[name] = values.join(";")
        }
      end

    end
  end
end
