module Saml
  module Kit
    module Cli
      class Decode < Thor
        desc 'redirect uri', 'Decodes the uri using the HTTP Redirect binding'
        method_option :export, default: nil, required: false
        def redirect(uri)
          print_report_for(redirect_binding.deserialize(uri))
        rescue StandardError => error
          say error.message, :red
        end

        desc(
          'post saml',
          'Decodes the SAMLRequest/SAMLResponse using the HTTP Post binding'
        )
        method_option :export, default: nil, required: false
        def post(saml)
          print_report_for(post_binding.deserialize('SAMLRequest' => saml))
        rescue StandardError => error
          say error.message, :red
        end

        desc 'raw <file>', 'Decode the contents of a decoded file'
        def raw(file)
          content = IO.read(File.expand_path(file))
          print_report_for(Document.to_saml_document(content))
        rescue StandardError => error
          say error.message, :red
        end

        private

        def print_report_for(document, export = options[:export])
          IO.write(export, document.to_xml) if export
          2.times { say '' }
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
