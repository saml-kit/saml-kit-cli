RSpec.describe Saml::Kit::Cli do
  it 'has a version number' do
    expect(Saml::Kit::Cli::VERSION).not_to be_nil
  end

  describe "version" do
    let(:command) { "version" }

    specify { expect(status).to be_success }
    specify { expect(output).to include(Saml::Kit::Cli::VERSION) }
  end
end
