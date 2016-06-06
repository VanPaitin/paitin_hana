require "paitin_hana/version"

module PaitinHana
  class Application
    def call(env)
      [200, {}, ["I respond to all request"]]
    end
  end
end
