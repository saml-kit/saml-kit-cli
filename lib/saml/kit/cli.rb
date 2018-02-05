require "saml/kit"
require "thor"
require "yaml/store"

require "saml/kit/cli/decode"
require "saml/kit/cli/generate"
require "saml/kit/cli/metadata"
require "saml/kit/cli/version"
require "saml/kit/cli/yaml_registry"

module Saml
  module Kit
    module Cli
      class Application < Thor
        desc "decode SUBCOMMAND ...ARGS", "decode SAMLRequest/SAMLResponse."
        subcommand "decode", Decode

        desc "generate SUBCOMMAND ...ARGS", "generate SAML artifacts."
        subcommand "generate", Generate

        desc "metadata SUBCOMMAND ...ARGS", "Work with SAML Metadata."
        subcommand "metadata", Metadata
      end
    end
  end
end
