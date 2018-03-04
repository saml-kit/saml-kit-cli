RSpec.describe Saml::Kit::Cli::Commands::Certificate do
  let(:passphrase) { "password" }

  def execute(command)
    output = `bundle exec ruby ./exe/saml-kit #{command} 2>&1`
    [$?, output]
  end

  describe "keypair" do
    let(:because) { execute(command) }
    let(:status) { because[0] }
    let(:output) { because[1] }

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
end
