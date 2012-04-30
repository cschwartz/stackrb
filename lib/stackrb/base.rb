require "pry"
require "httparty"
require "json"

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

      def fetch(klass, uri, parameters = {}, query = {})
        json = request_objects_as_json(uri, parameters, query) 
        create_instances(json, klass)
      end

      def request_objects_as_json(uri, parameters, query)
        options = built_options query
        path = built_path uri, parameters
        response = HTTParty.get path, options
        JSON.parse response, :symbolize_names => true
      end

      def create_instances(json, klass)
        json[:items].map { |params| klass.new params }
      end

      def built_options(query)
        options = default_options
        options[:query] = query unless query.empty?

        options
      end

      def built_path(uri, parameters)
        uri % prepare_parameters(parameters)
      end

      def convert_variable(instance, name, value)
        value = @converters[name].call(value)
        instance.instance_variable_set "@#{name}", value
      end

      def prepare_parameters(parameters)
        parameters.each_with_object({}) { |(name, values), hash|
          hash[name] = values.join(";")
        }
      end

      def default_options
        { :base_uri => default_base_uri }
      end

      def default_base_uri
        "http://api.stackexchange.com/2.0"
      end
    end
  end
end
