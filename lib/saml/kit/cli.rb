require 'saml/kit'
require 'thor'
require 'yaml/store'

require 'saml/kit/cli/certificate'
require 'saml/kit/cli/decode'
require 'saml/kit/cli/metadata'
require 'saml/kit/cli/report'
require 'saml/kit/cli/version'
require 'saml/kit/cli/xml_digital_signature'
require 'saml/kit/cli/yaml_registry'

module Saml
  module Kit
    module Cli
      class Application < Thor
        desc 'decode SUBCOMMAND ...ARGS', 'decode SAMLRequest/SAMLResponse.'
        subcommand 'decode', Decode

        desc 'certificate SUBCOMMAND ...ARGS', 'Work with SAML Certificates.'
        subcommand 'certificate', Certificate

        desc 'metadata SUBCOMMAND ...ARGS', 'Work with SAML Metadata.'
        subcommand 'metadata', Metadata

        desc 'xmldsig SUBCOMMAND ...ARGS', 'Check XML digital signatures.'
        subcommand 'xmldsig', XmlDigitalSignature
      end
    end
  end
end
