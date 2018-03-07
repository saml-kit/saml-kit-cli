module Saml
  module Kit
    module Cli
      class Report
        attr_reader :document

        def initialize(document)
          @document = document
        end

        def print(shell)
          if document.is_a?(Saml::Kit::InvalidDocument)
            shell.say_status :error, "Decoded #{document.send(:name)}"
          else
            shell.say_status :success, "Decoded #{document.send(:name)}"
          end
          shell.print_table document.build_table
          signature = document.signature
          if signature.present? && signature.certificate.present?
            shell.say(signature.certificate.x509.to_text)
          end
          shell.say document.to_xml(pretty: true), :green
          document.errors.full_messages.each do |error|
            shell.say_status :error, error, :red
          end
        end
      end
    end
  end
end
