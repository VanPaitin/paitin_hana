module PaitinHana
  module Routing
    class Mapper
      attr_reader :routes
      def initialize(routes, env)
        @routes = routes
        @env = env
      end

      def update_params(request)
        route = routes.detect do |router|
          router[:pattern][0] =~ request.path_info
        end
        match_data = Regexp.last_match
        route[:pattern][1].each do |placeholder|
          request.update_param(placeholder, match_data[placeholder])
        end
        controller_instance, action = get_controller_and_action(route)
        dispatcher(controller_instance, action)
      end

      def get_controller_and_action(route)
        controller = Object.const_get(route[:class_and_method][0])
        action = route[:class_and_method][1]
        controller_instance = controller.new(@env)
        [controller_instance, action]
      end

      def dispatcher(controller_instance, action)
        controller_instance.send(action)
        unless controller_instance.get_response
          controller_instance.render(action)
        end
        controller_instance.get_response
      end
    end
  end
end
