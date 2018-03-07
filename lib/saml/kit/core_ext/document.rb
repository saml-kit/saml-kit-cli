module Saml
  module Kit
    class Document
      def build_table(table = [])
        table.push(['ID', id])
        table.push(['Issuer', issuer])
        table.push(['Version', version])
        table.push(['Issue Instant', issue_instant.iso8601])
        table.push(['Type', name])
        table.push(['Valid', valid?])
        table.push(['Signed?', signed?])
        table.push(['Trusted?', trusted?])
        signature.build_table(table)
        table
      end
    end

    class AuthenticationRequest
      def build_table(table = [])
        super(table)
        table.push(['ACS', assertion_consumer_service_url])
        table.push(['Name Id Format', name_id_format])
        table
      end
    end

    class Response
      def build_table(table = [])
        super(table)
        assertion.build_table(table) if assertion.present?
        table
      end
    end

    class Assertion
      def build_table(table = [])
        table.push(['Assertion Present?', present?])
        table.push(['Issuer', issuer])
        table.push(['Name Id', name_id])
        table.push(['Attributes', attributes.inspect])
        table.push(['Not Before', started_at])
        table.push(['Not After', expired_at])
        table.push(['Audiences', audiences.inspect])
        table.push(['Encrypted?', encrypted?])
        table.push(['Decryptable', decryptable?])
        signature.build_table(table)
      end
    end

    class LogoutRequest
      def build_table(table = [])
        super(table)
        table.push(['Name Id', name_id])
        table
      end
    end

    class Metadata
      def build_table(table = [])
        table.push(['Entity Id', entity_id])
        table.push(['Type', name])
        table.push(['Valid', valid?])
        table.push(['Name Id Formats', name_id_formats.inspect])
        table.push(['Organization', organization_name])
        table.push(['Url', organization_url])
        table.push(['Contact', contact_person_company])
        %w[
          SingleSignOnService
          SingleLogoutService
          AssertionConsumerService
        ].each do |type|
          services(type).each do |service|
            table.push([type, [service.location, service.binding]])
          end
        end
        certificates.each do |certificate|
          table.push(['', certificate.x509.to_text])
        end
        signature.build_table(table)
        table
      end
    end

    class Signature
      def build_table(table = [])
        return table unless present?
        table.push(['Digest Value', digest_value])
        table.push(['Expected Digest Value', expected_digest_value])
        table.push(['Digest Method', digest_method])
        table.push(['Signature Value', truncate(signature_value)])
        table.push(['Signature Method', signature_method])
        table.push(['Canonicalization Method', canonicalization_method])
        table.push(['', certificate.x509.to_text])
        table
      end

      private

      def truncate(text, max: 50)
        text.length >= max ? "#{text[0..max]}..." : text
      end
    end
  end
end
