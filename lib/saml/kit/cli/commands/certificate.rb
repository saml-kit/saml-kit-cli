module Saml
  module Kit
    module Cli
      module Commands
        class Certificate < Thor
          desc 'keypair', 'Create a key pair using a self signed certificate.'
          method_option(
            :format,
            default: 'pem',
            required: false,
            enum: %w[pem env]
          )
          method_option :passphrase, default: nil, required: false
          def keypair
            GenerateKeyPair.new(
              passphrase: options[:passphrase],
              format: options[:format]
            ).run(self)
          end

          desc 'dump', 'Dump the details of a X509 Certificate.'
          def dump(raw)
            CertificateReport.new(raw).print(self)
          end
        end
      end
    end
  end
end
