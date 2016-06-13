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
      file_name = File.join("app/views", controller_name, "#{view_name}.erb")
      template = Tilt::ERBTemplate.new(file_name)
      vars = {}
      instance_variables.each do |var|
        key = var.to_s.gsub("@", "").to_sym
        vars[key] = instance_variable_get(var)
      end
      template.render(self, locals.merge(vars))
    end

    def controller_name
      self.class.to_s.gsub(/Controller$/, "").snake_case
    end
  end
end
