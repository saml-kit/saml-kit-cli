module Saml
  module Kit
    module Cli
      module Commands
        class XmlDigitalSignature < Thor
          desc(
            'verify file',
            'Verify if the contents of a file has a valid signature.'
          )
          method_option(
            :format,
            default: 'short',
            required: false,
            enum: %w[short full]
          )
          def verify(file)
            report = SignatureReport.new(file, format: options[:format])
            report.print(self)
          end
        end
      end
    end
  end
end
