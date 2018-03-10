# frozen_string_literal: true

module Saml
  module Kit
    module Cli
      class CertificateReport
        HEADER = [
          'Subject', 'Issuer', 'Serial',
          'Not Before', 'Not After', 'Fingerprint'
        ].freeze
        attr_reader :certificate, :x509

        def initialize(raw)
          @certificate = ::Xml::Kit::Certificate.new(raw, use: :unknown)
          @x509 = @certificate.x509
        end

        def print(shell)
          shell.print_table([HEADER, body])
          shell.say(x509.to_text, :green)
        end

        private

        def fingerprint
          certificate.fingerprint
        end

        def body
          [
            x509.subject, x509.issuer, x509.serial,
            x509.not_before, x509.not_after, fingerprint
          ]
        end
      end
    end
  end
end
