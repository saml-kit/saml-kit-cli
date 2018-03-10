require 'saml/kit'
require 'thor'
require 'yaml/store'
require 'uri'

require 'saml/kit/core_ext/assertion'
require 'saml/kit/core_ext/authentication_request'
require 'saml/kit/core_ext/document'
require 'saml/kit/core_ext/document'
require 'saml/kit/core_ext/logout_request'
require 'saml/kit/core_ext/metadata'
require 'saml/kit/core_ext/response'
require 'saml/kit/core_ext/signature'

require 'saml/kit/cli/certificate_report'
require 'saml/kit/cli/commands'
require 'saml/kit/cli/generate_key_pair'
require 'saml/kit/cli/report'
require 'saml/kit/cli/signature_report'
require 'saml/kit/cli/version'
require 'saml/kit/cli/yaml_registry'

module Saml
  module Kit
    module Cli
      class Application < Thor
        desc 'decode SUBCOMMAND ...ARGS', 'decode SAMLRequest/SAMLResponse.'
        subcommand 'decode', Commands::Decode

        desc 'certificate SUBCOMMAND ...ARGS', 'Work with SAML Certificates.'
        subcommand 'certificate', Commands::Certificate

        desc 'metadata SUBCOMMAND ...ARGS', 'Work with SAML Metadata.'
        subcommand 'metadata', Commands::Metadata

        desc 'xmldsig SUBCOMMAND ...ARGS', 'Check XML digital signatures.'
        subcommand 'xmldsig', Commands::XmlDigitalSignature

        desc 'version', 'Display the current version'
        def version
          say Saml::Kit::Cli::VERSION
        end
      end
    end
  end
end
