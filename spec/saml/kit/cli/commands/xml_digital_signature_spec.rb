RSpec.describe Saml::Kit::Cli::Commands::Certificate do
  describe "#verify" do
    let(:command) { "xmldsig verify #{tempfile}" }
    let(:tempfile) { Tempfile.new('saml-kit').path }
    let(:configuration) do
      Saml::Kit::Configuration.new do |config|
        config.generate_key_pair_for(use: :signing)
      end
    end

    before { IO.write(tempfile, xml) }
    after { File.unlink(tempfile) }

    context "file is valid" do
      let(:document) { Saml::Kit::AuthenticationRequest.build(configuration: configuration) }
      let(:xml) { document.to_xml }

      specify { expect(status).to be_success }
      specify { expect(output).to include(document.to_xml(pretty: true)) }
      specify { expect(output).to include("success  #{tempfile} is valid") }
    end
  end
end
