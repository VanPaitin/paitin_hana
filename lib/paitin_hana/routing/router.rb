module PaitinHana
  module Routing
    class Router
      def initialize
        @app_routes = Hash.new { |hash, key| hash[key] = [] }
      end

      @@allowed_methods = [:get, :post, :put, :patch, :delete]

      @@allowed_methods.each do |method_name|
        define_method(method_name) do |path, to:|
          path = "/#{path}" unless path[0] = "/"
          @route_info = {
                          path: path,
                          pattern: pattern_for(path),
                          class_and_method: controller_and_action_for(to)
                        }
          @app_routes[method_name] << @route_info
        end
      end

      def draw &block
        instance_eval &block
      end

      def root(to)
        get "/", to: to
      end

      def pattern_for(path)
        placeholders = []
        my_path = path.gsub(/(:\w+)/) do |match|
          placeholders << match[1..-1].freeze
          "(?<#{placeholders.last}>\\w+)"
        end
        [/^#{my_path}$/, placeholders]
      end

      def check_url(env)
        @request = Rack::Request.new(env)
        @request_method = @request.request_method.downcase.to_sym
        route_match = @app_routes[@request_method].any? do |route|
          route[:pattern][0] =~ @request.path_info
        end
        unless route_match
          return [404, {}, ["Route not found"]]
        end
        map_to_action(env)
      end

      def controller_and_action_for(path_to)
        controller_path, action = path_to.split("#")
        controller = "#{controller_path.camel_case}Controller"
        [controller, action.to_sym]
      end

      def map_to_action(env)
        app_routes = @app_routes[@request_method]
        mapper = PaitinHana::Routing::Mapper.new(app_routes, env)
        mapper.update_params(@request)
      end
    end
  end
end
