RSpec.describe Saml::Kit::Cli::Commands::Certificate do
  describe "#redirect" do
    let(:command) { "decode redirect #{saml}" }
    let(:saml) do
      binding = Saml::Kit::Bindings::HttpRedirect.new(location: '')
      document = Saml::Kit::AuthenticationRequest.builder
      binding.serialize(document)
    end

    specify { expect(status).to be_success }
  end
end
