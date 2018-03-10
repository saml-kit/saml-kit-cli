# frozen_string_literal: true

module Saml
  module Kit
    class Metadata
      TABLE = {
        'Entity Id' => ->(x) { x.entity_id },
        'Type' => ->(x) { x.name },
        'Valid' => ->(x) { x.valid? },
        'Name Id Formats' => ->(x) { x.name_id_formats.inspect },
        'Organization' => ->(x) { x.organization_name },
        'Url' => ->(x) { x.organization_url },
        'Contact' => ->(x) { x.contact_person_company },
      }.freeze

      SERVICES = %w[
        SingleSignOnService
        SingleLogoutService
        AssertionConsumerService
      ].freeze

      def build_table(table = [])
        TABLE.each { |key, callable| table.push([key, callable.call(self)]) }
        build_services_table(table)
        certificates.each do |certificate|
          table.push(['', certificate.x509.to_text])
        end
        signature.build_table(table)
      end

      def build_services_table(table)
        SERVICES.each do |type|
          services(type).each do |service|
            table.push([type, [service.location, service.binding]])
          end
        end
      end
    end
  end
end
