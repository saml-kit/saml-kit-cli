RSpec.describe Saml::Kit::Cli::Commands::Certificate do
  let(:because) { execute(command) }
  let(:status) { because[0] }
  let(:output) { because[1] }

  def execute(command)
    full_command = "bundle exec ruby ./exe/saml-kit #{command} 2>&1"
    puts full_command
    output = `#{full_command}`
    [$?, output]
  end

  describe "keypair" do
    let(:passphrase) { "password" }

    describe "generating a pem" do
      let(:command) { "certificate keypair --passphrase #{passphrase}" }

      specify { expect(status).to be_success }
      specify { expect(output).to include(passphrase) }
      specify { expect(output).to include('-----BEGIN CERTIFICATE-----') }
      specify { expect(output).to include('-----END CERTIFICATE-----') }
      specify { expect(output).to include('-----BEGIN RSA PRIVATE KEY-----') }
      specify { expect(output).to include('-----END RSA PRIVATE KEY-----') }
      specify { expect(output).to include('Proc-Type: 4,ENCRYPTED') }
      specify { expect(output).to include('DEK-Info: AES-256-CBC,') }
    end

    describe "generating env format" do
      let(:command) { "certificate keypair --passphrase #{passphrase} --format env" }

      specify { expect(status).to be_success }
      specify { expect(output).to include(passphrase) }
      specify { expect(output).to include('X509_CERTIFICATE="-----BEGIN CERTIFICATE-----\n') }
      specify { expect(output).to include('PRIVATE_KEY="-----BEGIN RSA PRIVATE KEY-----\nProc-Type: 4,ENCRYPTED\nDEK-Info: AES-256-CBC') }
    end
  end

  describe "dump" do
    let(:command) { "certificate dump '#{base64_certificate}'" }
    let(:base64_certificate) { x509.to_pem }
    let(:x509) do
      certificate = OpenSSL::X509::Certificate.new
      key = OpenSSL::PKey::RSA.new(2048)
      certificate.subject = certificate.issuer = OpenSSL::X509::Name.parse('/C=CA/ST=AB/L=Calgary/O=SamlKit/OU=SamlKit/CN=SamlKit')
      certificate.not_before = Time.now
      certificate.not_after = certificate.not_before + 30 * 24 * 60 * 60
      certificate.public_key = key.public_key
      certificate.serial = 0x0
      certificate.version = 2
      certificate.sign(key, OpenSSL::Digest::SHA256.new)
      certificate
    end

    specify { expect(status).to be_success }
    specify { expect(output).to include(x509.to_text) }
  end
end
