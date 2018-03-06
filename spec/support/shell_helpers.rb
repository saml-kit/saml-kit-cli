require 'english'

RSpec.shared_context 'when executing the cli' do
  subject { execute(command) }

  let(:status) { subject[0] }
  let(:output) { subject[1] }
  let(:env) {}

  def execute(command, mute: false, env: self.env)
    full_command = "#{env} bundle exec ruby ./exe/saml-kit #{command} 2>&1"
    puts full_command unless mute
    output = `#{full_command}`
    [$CHILD_STATUS, output]
  end
end

RSpec.configure do |config|
  config.include_context 'when executing the cli'
end
