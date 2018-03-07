module Saml
  module Kit
    class LogoutRequest
      def build_table(table = [])
        super(table)
        table.push(['Name Id', name_id])
        table
      end
    end
  end
end
