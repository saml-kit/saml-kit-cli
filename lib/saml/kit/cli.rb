require "saml/kit"
require "saml/kit/cli/version"
require "thor"

module Saml
  module Kit
    module Cli
      class Decode < Thor
        desc "redirect uri", "Decodes the uri using the HTTP Redirect binding"
        def redirect(uri)
          binding = Saml::Kit::Bindings::HttpRedirect.new(location: '')
          uri = URI.parse(uri)
          query_params =  Hash[uri.query.split('&').map { |x| x.split('=', 2) }]
          document = binding.deserialize(query_params)

          2.times { say "" }
          say_status :success, "Decoded #{document.class}"
          print_table [
            ["ID", "Issuer", "Version", "Issue instant"],
            [document.id, document.issuer, document.version, document.issue_instant.iso8601 ]
          ]
          say ""
          say document.to_xml(pretty: true), :green
        end
      end

      class Application < Thor
        desc "decode SUBCOMMAND ...ARGS", "decode a SAMLRequest/SAMLResponse"
        subcommand "decode", Decode
      end
    end
  end
end
