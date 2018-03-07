module Saml
  module Kit
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
