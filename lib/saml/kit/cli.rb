require "saml/kit"
require "thor"

require "saml/kit/cli/version"
require "saml/kit/cli/decode"
require "saml/kit/cli/generate"

module Saml
  module Kit
    module Cli
      class Application < Thor
        desc "decode SUBCOMMAND ...ARGS", "decode SAMLRequest/SAMLResponse."
        subcommand "decode", Decode

        desc "generate SUBCOMMAND ...ARGS", "generate SAML artifacts."
        subcommand "generate", Generate
      end
    end
  end
end
