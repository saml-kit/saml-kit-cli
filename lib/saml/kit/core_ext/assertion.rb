module Saml
  module Kit
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
  end
end
