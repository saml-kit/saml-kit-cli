require "saml/kit/cli/version"
require "thor"

module Saml
  module Kit
    module Cli
      class Application < Thor
        desc "foo", "prints foo"
        def foo
          puts "foo"
        end
      end
    end
  end
end
