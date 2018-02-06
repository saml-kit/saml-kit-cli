module Saml
  module Kit
    module Cli
      class Certificate < Thor
        desc "keypair", "Create a key pair using a self signed certificate."
        method_option :format, default: "pem", required: false, enum: ["pem", "env"]
        method_option :passphrase, default: nil, required: false
        def keypair
          passphrase = options[:passphrase]
          format = options[:format]
          generator = ::Xml::Kit::SelfSignedCertificate.new
          certificate, private_key = generator.create(passphrase: passphrase)

          if "pem" == format
            say "** BEGIN PEM Format **", :green
            print certificate
            say private_key
            say "***********************", :green
          else
            say "** BEGIN ENV Format **", :green
            say "X509_CERTIFICATE=" + certificate.inspect
            say
            say "PRIVATE_KEY=" + private_key.inspect
            say "***********************", :green
          end

          say
          say "Private Key Passphrase:", :green
          say passphrase.inspect
        end

        desc "dump", "Dump the details of a X509 Certificate."
        def dump(raw)
          certificate = ::Xml::Kit::Certificate.new(raw, use: :unknown)
          x509 = certificate.x509
          print_table [
            ["Subject", "Issuer", "Serial", "Not Before", "Not After", "Fingerprint"],
            [x509.subject, x509.issuer, x509.serial, x509.not_before, x509.not_after, certificate.fingerprint]
          ]
          say x509.to_text, :green
        end
      end
    end
  end
end
