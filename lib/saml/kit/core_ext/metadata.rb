module Saml
  module Kit
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
  end
end
