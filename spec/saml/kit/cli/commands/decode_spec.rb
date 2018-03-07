RSpec.describe Saml::Kit::Cli::Commands::Decode do
  let(:user) { double(name_id_for: SecureRandom.uuid) }

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
    let(:post_binding) do
      Saml::Kit::Bindings::HttpPost.new(location: 'https://www.example.com/')
    end

    context 'when the document is an AuthnRequest' do
      let(:command) { "decode post #{post_binding.serialize(builder)[1]['SAMLRequest']}" }
      let(:builder) { Saml::Kit::AuthenticationRequest.builder }
      let(:document) { builder.build }

      specify { expect(status).to be_success }
      specify { expect(output).to include(document.to_xml(pretty: true)) }
      specify { expect(output).to include("Decoded #{document.send(:name)}") }
    end

    context 'when the document is a Response' do
      let(:command) { "decode post #{post_binding.serialize(builder)[1]['SAMLResponse']}" }
      let(:builder) do
        Saml::Kit::Response.builder(user) do |x|
          x.sign_with(Xml::Kit::KeyPair.generate(use: :signing))
        end
      end
      let(:document) { builder.build }

      specify { expect(status).to be_success }
      specify { expect(output).to include(document.to_xml(pretty: true)) }
      specify { expect(output).to include("Decoded #{document.send(:name)}") }
      specify { expect(output).to include(document.signature.certificate.x509.to_text) }
    end

    context 'when the document is a LogoutRequest' do
      let(:command) { "decode post #{post_binding.serialize(builder)[1]['SAMLRequest']}" }
      let(:builder) { Saml::Kit::LogoutRequest.builder(user) }
      let(:document) { builder.build }

      specify { expect(status).to be_success }
      specify { expect(output).to include(document.to_xml(pretty: true)) }
      specify { expect(output).to include("Decoded #{document.send(:name)}") }
      specify { expect(output).to include(user.name_id_for) }
    end

    context 'when the document is a LogoutResponse' do
      let(:command) { "decode post #{post_binding.serialize(builder)[1]['SAMLResponse']}" }
      let(:builder) { Saml::Kit::LogoutResponse.builder(request) }
      let(:request) { instance_double(Saml::Kit::AuthenticationRequest, id: Xml::Kit::Id.generate) }
      let(:document) { builder.build }

      specify { expect(status).to be_success }
      specify { expect(output).to include(document.to_xml(pretty: true)) }
      specify { expect(output).to include("Decoded #{document.send(:name)}") }
    end

    context 'when the document is  Invalid' do
      let(:command) { "decode post #{Base64.encode64('INVALID')}" }

      specify { expect(status).to be_success }
      specify { expect(output).to include('error  Decoded InvalidDocument') }
    end
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
