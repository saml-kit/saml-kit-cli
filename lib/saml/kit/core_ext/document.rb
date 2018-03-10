module Saml
  module Kit
    class Document
      TABLE = {
        'ID' => ->(x) { x.id },
        'Issuer' => ->(x) { x.issuer },
        'Version' => ->(x) { x.version },
        'Issue Instant' => ->(x) { x.issue_instant.iso8601 },
        'Type' => ->(x) { x.name },
        'Valid' => ->(x) { x.valid? },
        'Signed?' => ->(x) { x.signed? },
        'Trusted?' => ->(x) { x.trusted? },
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
