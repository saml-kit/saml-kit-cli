RSpec.describe Saml::Kit::Cli::Commands::Certificate do
  let(:passphrase) { "password" }

  def execute(command)
    output = `bundle exec ruby ./exe/saml-kit #{command} 2>&1`
    [$?, output]
  end

  it 'generates a new keypair' do
    status, output = execute("certificate keypair --passphrase #{passphrase}")
    expect(status).to be_success
    expect(output).to include(passphrase)
  end
end
