# frozen_string_literal: true

module Saml
  module Kit
    module Cli
      class Report
        attr_reader :document

        def initialize(document)
          @document = document
        end

        def print(shell)
          shell.say_status status, "Decoded #{document.send(:name)}"
          shell.print_table document.build_table
          print_signature(document.signature, shell)
          print_xml(shell)
          print_errors(document.errors.full_messages, shell)
        end

        private

        def status
          document.is_a?(Saml::Kit::InvalidDocument) ? :error : :sucess
        end

        def print_errors(errors, shell)
          errors.each { |x| shell.say_status :error, x, :red }
        end

        def print_signature(signature, shell)
          return if !signature.present? || !signature.certificate.present?
          shell.say(signature.certificate.x509.to_text)
        end

        def print_xml(shell)
          shell.say document.to_xml(pretty: true), :green
        end
      end
    end
  end
end
