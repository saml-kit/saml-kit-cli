RSpec.describe Saml::Kit::Cli::Commands::Metadata do
  let(:entity_id) { 'https://saml-kit-proof.herokuapp.com/metadata' }

  describe "#register" do
    let(:env) { "SAMLKITRC=#{tempfile}" }
    let(:tempfile) { Tempfile.new('saml-kit').path }
    let(:command) { "metadata register #{entity_id}" }

    after { File.unlink(tempfile) }

    specify { expect(status).to be_success }
    specify { expect(output).to include(entity_id) }
    specify { expect(output).to match(/EntityDescriptor/) }
    specify { expect(output).to match(/opening connection to saml-kit-proof.herokuapp.com:443.../) }
  end

  describe "#show" do
    before :each do
      env = "SAMLKITRC=#{Tempfile.new('saml-kit').path}"
      execute("metadata register #{entity_id}", env: env)
    end

    let(:command) { "metadata show #{entity_id}" }

    specify { expect(status).to be_success }
    specify { expect(output).to include(entity_id) }
  end

  describe "#list" do
    before :each do
      env = "SAMLKITRC=#{Tempfile.new('saml-kit').path}"
      execute("metadata register #{entity_id}", env: env)
    end

    let(:command) { "metadata list" }

    specify { expect(status).to be_success }
    specify { expect(output).to include(entity_id) }
  end
end
