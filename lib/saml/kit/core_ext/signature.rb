# frozen_string_literal: true

module Saml
  module Kit
    class Signature
      TABLE = {
        'Digest Value' => ->(x) { x.digest_value },
        'Expected Digest Value' => ->(x) { x.expected_digest_value },
        'Digest Method' => ->(x) { x.digest_method },
        'Signature Value' => ->(x) { x.truncate(x.signature_value) },
        'Signature Method' => ->(x) { x.signature_method },
        'Canonicalization Method' => ->(x) { x.canonicalization_method },
      }.freeze

      def build_table(table = [])
        return table unless present?
        TABLE.each do |key, callable|
          table.push([key, callable.call(self)])
        end
        table.push(['', certificate.x509.to_text])
      end

      def truncate(text, max: 50)
        text.length >= max ? "#{text[0..max]}..." : text
      end
    end
  end
end
