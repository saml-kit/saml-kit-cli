module Saml
  module Kit
    class Response
      def build_table(table = [])
        super(table)
        assertion.build_table(table) if assertion.present?
        table
      end
    end
  end
end
