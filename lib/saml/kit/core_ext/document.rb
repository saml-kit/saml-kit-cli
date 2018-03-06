module Saml
  module Kit
    class Document
      def build_header(table = [])
        table.push(['ID', id])
        table.push(['Issuer', issuer])
        table.push(['Version', version])
        table.push(['Issue Instant', issue_instant.iso8601])
        table.push(['Type', send(:name)])
        table.push(['Valid', valid?])
        table.push(['Signed?', signed?])
        table.push(['Trusted?', trusted?])
        signature.build_header(table) if signature.present?
      end

      def truncate(text, max: 50)
        text.length >= max ? "#{text[0..max]}..." : text
      end
    end

    class Metadata
      def build_header(table = [])
        table.push(['Entity Id', entity_id])
        table.push(['Type', send(:name)])
        table.push(['Valid', valid?])
        table.push(['Name Id Formats', name_id_formats.inspect])
        table.push(['Organization', organization_name])
        table.push(['Url', organization_url])
        table.push(['Contact', contact_person_company])
        %w[SingleSignOnService SingleLogoutService AssertionConsumerService].each do |type|
          services(type).each do |service|
            table.push([type, [service.location, service.binding]])
          end
        end
        certificates.each do |certificate|
          table.push(['', certificate.x509.to_text])
        end
        signature.build_header(table) if signature.present?
      end
    end

    class Signature
      def build_header(table = [])
        table.push(['Digest Value', digest_value])
        table.push([
          'Expected Digest Value', expected_digest_value
        ])
        table.push(['Digest Method', digest_method])
        table.push(['Signature Value', truncate(signature_value)])
        table.push(['Signature Method', signature_method])
        table.push([
          'Canonicalization Method', canonicalization_method
        ])
        table.push(['', certificate.x509.to_text])
      end
    end
  end
end
