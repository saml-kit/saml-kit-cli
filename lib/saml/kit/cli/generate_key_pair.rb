module Saml
  module Kit
    module Cli
      class GenerateKeyPair
        attr_reader :passphrase, :format

        def initialize(passphrase:, format:)
          @passphrase = passphrase
          @format = format
        end

        def run(shell)
          certificate, private_key = generate
          if pem?
            shell.say certificate
            shell.say private_key
          else
            shell.say 'X509_CERTIFICATE=' + certificate.inspect
            shell.say 'PRIVATE_KEY=' + private_key.inspect
          end
          shell.say 'Private Key Passphrase:', :green
          shell.say passphrase.inspect
        end

        private

        def generate
          generator = ::Xml::Kit::SelfSignedCertificate.new
          generator.create(passphrase: passphrase)
        end

        def pem?
          format == 'pem'
        end
      end
    end
  end
end
