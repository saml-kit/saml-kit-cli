module Saml
  module Kit
    module Cli
      class Decode < Thor
        desc "redirect uri", "Decodes the uri using the HTTP Redirect binding"
        def redirect(uri)
          print_report_for(redirect_binding.deserialize(uri))
        rescue StandardError => error
          say error.message, :red
        end

        desc "post saml", "Decodes the SAMLRequest/SAMLResponse using the HTTP Post binding"
        def post(saml_request)
          print_report_for(post_binding.deserialize('SAMLRequest' => saml_request))
        rescue StandardError => error
          say error.message, :red
        end

        private

        def print_report_for(document)
          2.times { say "" }
          Report.new(document).print(self)
        end

        def post_binding(location = '')
          Saml::Kit::Bindings::HttpPost.new(location: location)
        end

        def redirect_binding(location = '')
          Saml::Kit::Bindings::HttpRedirect.new(location: location)
        end
      end
    end
  end
end
