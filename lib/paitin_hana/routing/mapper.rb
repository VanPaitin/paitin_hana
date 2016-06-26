module PaitinHana
  module Routing
    class Mapper
      attr_reader :routes
      def initialize(routes)
        @routes = routes
      end

      def update_params(request, env)
        route = routes.detect do |router|
          router[:pattern][0] =~ env["PATH_INFO"]
        end
        match_data = Regexp.last_match
        route[:pattern][1].each do |placeholder|
          request.update_param(placeholder, match_data[placeholder])
        end
        get_controller_and_action(route, env)
      end

      def get_controller_and_action(route, env)
        controller = Object.const_get(route[:class_and_method][0])
        action = route[:class_and_method][1]
        controller_instance = controller.new(env)
        response = controller_instance.send(action)
        dispatcher(controller_instance, action)
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
