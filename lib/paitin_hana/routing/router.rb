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
          class_and_method = controller_and_action_for(to)
          @route_info = {
                          path: path,
                          pattern: pattern_for(path),
                          class_and_method: class_and_method
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
        path.gsub!(/(:\w+)/) do |match|
          placeholders << match[1..-1]
          "(?<#{placeholders.last}>\\w+)"
        end
        [/^#{path}$/, placeholders]
      end

      def check_url(request, env)
        request_method = env["REQUEST_METHOD"].downcase.to_sym
        if !@@allowed_methods.include?(request_method)
          return [404, {}, ["invalid method"]]
        end
        url = env["PATH_INFO"]
        if @app_routes[request_method].any? { |route| route[:pattern][0] =~ url }
          route = @app_routes[request_method].detect { |router| router[:pattern][0] =~ url }
          match_data = Regexp.last_match
          route[:pattern][1].each do |placeholder|
            request.update_param(placeholder, match_data[placeholder])
          end
          controller = Object.const_get(route[:class_and_method][0])
          action = route[:class_and_method][1]
          controller_instance = controller.new(env)
          response = controller_instance.send(action)
          dispatcher(controller_instance, action)
        else
          [404, {}, ["Route not found"]]
        end
      end

      def controller_and_action_for(path_to)
        controller_path, action = path_to.split("#")
        controller = "#{controller_path.camel_case}Controller"
        [controller, action.to_sym]
      end

      def dispatcher(controller_instance, action)
        if controller_instance.get_response
          controller_instance.get_response
        else
          controller_instance.render(action)
          controller_instance.get_response
        end
      end
    end
  end
end
