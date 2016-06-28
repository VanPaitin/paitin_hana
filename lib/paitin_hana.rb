require "paitin_hana/version"
require "paitin_hana/base_controller"
require "pry"
require "paitin_hana/utilities"
require "paitin_hana/dependencies"
require "paitin_hana/routing/router"
require "paitin_hana/routing/mapper"
require "paitin_hana/orm/database"
require "paitin_hana/orm/base_model"

module PaitinHana
  class Application
    attr_reader :routes
    def initialize
      @routes = PaitinHana::Routing::Router.new
    end

    def call(env)
      if env["PATH_INFO"] == "/favicon.ico"
        return [500, {}, []]
      end
      routes.check_url(env)
    end
  end
end
