# frozen_string_literal: true

module Saml
  module Kit
    class AuthenticationRequest
      def build_table(table = [])
        super(table)
        table.push(['ACS', assertion_consumer_service_url])
        table.push(['Name Id Format', name_id_format])
        table
      end
    end
  end
end
