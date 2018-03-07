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
  end
end
