module Saml
  module Kit
    class Assertion
      TABLE = {
        'Assertion Present?' => ->(x) { x.present? },
        'Issuer' => ->(x) { x.issuer },
        'Name Id' => ->(x) { x.name_id },
        'Attributes' => ->(x) { x.attributes.inspect },
        'Not Before' => ->(x) { x.started_at },
        'Not After' => ->(x) { x.expired_at },
        'Audiences' => ->(x) { x.audiences.inspect },
        'Encrypted?' => ->(x) { x.encrypted? },
        'Decryptable' => ->(x) { x.decryptable? },
      }.freeze

      def build_table(table = [])
        TABLE.each do |key, callable|
          table.push([key, callable.call(self)])
        end
        signature.build_table(table)
      end
    end
  end
end
