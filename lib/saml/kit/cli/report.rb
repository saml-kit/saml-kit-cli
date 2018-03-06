module Saml
  module Kit
    module Cli
      class Report
        attr_reader :document

        def initialize(document)
          @document = document
        end

        def print(shell)
          shell.say_status :success, "Decoded #{document.send(:name)}"
          shell.print_table build_table_for(document)
          signature = document.signature
          if signature.present? && signature.certificate.present?
            shell.say(signature.certificate.x509.to_text)
          end
          shell.say document.to_xml(pretty: true), :green
          document.errors.full_messages.each do |error|
            shell.say_status :error, error, :red
          end
        end

        private

        def truncate(text, max: 50)
          text.length >= max ? "#{text[0..max]}..." : text
        end

        def build_table_for(document)
          table = []
          document.build_header(table)
          document.build_body(table)
          table
        end
      end
    end
  end
end
