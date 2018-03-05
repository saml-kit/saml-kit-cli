require 'tempfile'

RSpec.describe Saml::Kit::Cli::Commands::Metadata do
  describe "#register" do
    let(:env) { "SAMLKITRC=#{Tempfile.new('saml-kit').path}" }
    let(:command) { "metadata register #{url}" }
    let(:url) { 'https://saml-kit-proof.herokuapp.com/metadata' }

    specify { expect(status).to be_success }
    specify { expect(output).to include(url) }
    specify { expect(output).to match(/EntityDescriptor/) }
    specify { expect(output).to match(/opening connection to saml-kit-proof.herokuapp.com:443.../) }
  end
end
