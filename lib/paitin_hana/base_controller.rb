require "erb"
require 'tilt'

module PaitinHana
  class BaseController
    attr_reader :request

    def initialize(env)
      @request ||= Rack::Request.new(env)
    end

    def params
      request.params
    end

    def redirect_to(path, status: 301)
      response([], status, Location: path)
    end

    def response(body, status = 200, headers = {})
      @response ||= Rack::Response.new(body, status, headers)
    end

    def get_response
      @response
    end

    def render(*args)
      response(render_template(*args))
    end

    def render_template(view_name, locals = {})
      locals[:title] = view_name
      file_name = Tilt::ERBTemplate.new(
        File.join("app/views", controller_name, "#{view_name}.erb")
      )
      template = Tilt::ERBTemplate.new("app/views/layout/application.erb")
      template.render(self, locals) do
        file_name.render(self, locals)
      end
    end

    def controller_name
      self.class.to_s.gsub(/Controller$/, "").snake_case
    end
  end
end
