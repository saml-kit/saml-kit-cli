RSpec.describe Saml::Kit::Cli::Commands::Metadata do
  let(:entity_id) { 'https://saml-kit-proof.herokuapp.com/metadata' }
  let(:env) { "SAMLKITRC=#{tempfile}" }
  let(:tempfile) { Tempfile.new('saml-kit').path }

  after { File.unlink(tempfile) if File.exist?(tempfile) }

  describe '#register' do
    let(:command) { "metadata register #{entity_id}" }

    specify { expect(status).to be_success }
    specify { expect(output).to include(entity_id) }
    specify { expect(output).to match(/EntityDescriptor/) }
    specify { expect(output).to match(/opening connection to saml-kit-proof.herokuapp.com:443.../) }
  end

  describe '#show' do
    let(:command) { "metadata show #{entity_id}" }

    context 'when the entity_id is registered' do
      before { execute("metadata register #{entity_id}") }

      specify { expect(status).to be_success }
      specify { expect(output).to include(entity_id) }
    end

    context 'when the entity_id is not registered' do
      specify { expect(status).to be_success }
      specify { expect(output).to include("`#{entity_id}` is not registered") }
    end
  end

  describe '#list' do
    let(:command) { 'metadata list' }

    context 'when a metadata is registered' do
      before { execute("metadata register #{entity_id}") }

      specify { expect(status).to be_success }
      specify { expect(output).to include(entity_id) }
    end

    context 'when zero metadata is registered' do
      specify { expect(status).to be_success }
      specify { expect(output).to include('Register metadata using `saml-kit metadata register <url>`') }
    end
  end
end
