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
          shell.print_table [
            ['ID', document.id],
            ['Issuer', document.issuer],
            ['Version', document.version],
            ['Issue Instant', document.issue_instant.iso8601],
            ['Type', document.send(:name)],
            ['Valid', document.valid?],
            ['Signed?', document.signed?],
            ['Trusted?', document.trusted?],
          ]
          document.errors.full_messages.each do |error|
            shell.say_status :error, error, :red
          end
          shell.say ""
          shell.say document.to_xml(pretty: true), :green
        end

        private

        def truncate(text, max: 50)
          if text.length >= max
            "#{text[0..max]}..."
          else
            text
          end
        end
      end
    end
  end
end
