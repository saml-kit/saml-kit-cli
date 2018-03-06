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

        def build_body_for(document, table)
          case document
          when Saml::Kit::AuthenticationRequest
            table.push(['ACS', document.assertion_consumer_service_url])
            table.push(['Name Id Format', document.name_id_format])
          when Saml::Kit::LogoutRequest
            table.push(['Name Id', document.name_id])
          when Saml::Kit::Response
            table.push(['Assertion Present?', document.assertion.present?])
            table.push(['Issuer', document.assertion.issuer])
            table.push(['Name Id', document.assertion.name_id])
            table.push(['Signed?', document.assertion.signed?])
            table.push(['Attributes', document.assertion.attributes.inspect])
            table.push(['Not Before', document.assertion.started_at])
            table.push(['Not After', document.assertion.expired_at])
            table.push(['Audiences', document.assertion.audiences.inspect])
            table.push(['Encrypted?', document.assertion.encrypted?])
            table.push(['Decryptable', document.assertion.decryptable?])
            if document.assertion.present?
              signature = document.assertion.signature
              table.push(['Digest Value', signature.digest_value])
              table.push([
                'Expected Digest Value', signature.expected_digest_value
              ])
              table.push(['Digest Method', signature.digest_method])
              table.push([
                'Signature Value', truncate(signature.signature_value)
              ])
              table.push(['Signature Method', signature.signature_method])
              table.push([
                'Canonicalization Method', signature.canonicalization_method
              ])
              table.push(['', signature.certificate.x509.to_text])
            end
            table
          end
        end

        def build_table_for(document)
          table = []
          document.build_header(table)
          build_body_for(document, table)
          table
        end
      end
    end
  end
end
