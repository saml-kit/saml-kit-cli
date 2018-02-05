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

        desc "post saml", "Decodes the SAMLRequest/SAMLResponse using the HTTP Post binding"
        def post(saml_request)
          binding = Saml::Kit::Bindings::HttpPost.new(location: '')
          document = binding.deserialize('SAMLRequest' => saml_request)
          2.times { say "" }
          say_status :success, "Decoded #{document.class}"
          print_table [
            ["ID", "Issuer", "Version", "Issue instant", "Type", "Valid", "Signed", "Trusted"],
            [document.id, document.issuer, document.version, document.issue_instant.iso8601, document.class, document.valid?, document.signed?, document.trusted? ]
          ]
          document.errors.full_messages.each do |error|
            say_status :error, error, :red
          end
          say ""
          say document.to_xml(pretty: true), :green
        end
      end
    end
  end
end
