RSpec.describe Saml::Kit::Cli::Commands::Decode do
  describe '#redirect' do
    let(:command) { "decode redirect #{redirect_binding.serialize(builder)[0]}" }
    let(:document) { builder.build }
    let(:builder) do
      Saml::Kit::AuthenticationRequest.builder do |x|
        x.sign_with(Xml::Kit::KeyPair.generate(use: :signing))
      end
    end
    let(:redirect_binding) do
      Saml::Kit::Bindings::HttpRedirect.new(location: 'https://www.example.com/')
    end

    specify { expect(status).to be_success }
    specify { expect(output).to include(document.to_xml(pretty: true)) }
    specify { expect(output).to include("Decoded #{document.send(:name)}") }
    specify { expect(output).not_to include('Signature Value') }
  end

  describe '#post' do
    let(:command) { "decode post #{post_binding.serialize(builder)[1]['SAMLResponse']}" }
    let(:document) { builder.build }
    let(:user) { double(name_id_for: SecureRandom.uuid) }
    let(:builder) do
      Saml::Kit::Response.builder(user) do |x|
        x.sign_with(Xml::Kit::KeyPair.generate(use: :signing))
      end
    end
    let(:post_binding) do
      Saml::Kit::Bindings::HttpPost.new(location: 'https://www.example.com/')
    end

    specify { expect(status).to be_success }
    specify { expect(output).to include(document.to_xml(pretty: true)) }
    specify { expect(output).to include("Decoded #{document.send(:name)}") }
    specify { expect(output).to include(document.signature.certificate.x509.to_text) }
  end

  describe '#raw' do
    let(:command) { "decode raw #{tempfile}" }
    let(:tempfile) { Tempfile.new('saml-kit').path }
    let(:document) { Saml::Kit::AuthenticationRequest.build }

    before { IO.write(tempfile, document.to_xml) }
    after { File.unlink(tempfile) }

    specify { expect(status).to be_success }
    specify { expect(output).to include(document.to_xml(pretty: true)) }
    specify { expect(output).to include("Decoded #{document.send(:name)}") }
  end
end
