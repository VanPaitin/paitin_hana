require "paitin_hana/version"
require "paitin_hana/base_controller"
require "pry"
require "paitin_hana/utilities"
require "paitin_hana/dependencies"
require "paitin_hana/routing/router"

module PaitinHana
  class Application
    def call(env)
      if env["PATH_INFO"] == "/favicon.ico"
        return [500, {}, []]
      end
      get_rack_app(env).call(env)
    end
  end
end
