# Saml::Kit::Cli

[![Build Status](https://travis-ci.org/saml-kit/saml-kit-cli.svg?branch=master)](https://travis-ci.org/saml-kit/saml-kit-cli)
[![Maintainability](https://api.codeclimate.com/v1/badges/f303b0bfa878d7b81722/maintainability)](https://codeclimate.com/github/saml-kit/saml-kit-cli/maintainability)
[![Security](https://hakiri.io/github/saml-kit/saml-kit-cli/master.svg)](https://hakiri.io/github/saml-kit/saml-kit-cli/master)

## Installation

```ruby
gem install 'saml-kit-cli'
```

## Usage

```bash
も saml-kit
Commands:
  saml-kit certificate SUBCOMMAND ...ARGS  # Work with SAML Certificates.
  saml-kit decode SUBCOMMAND ...ARGS       # decode SAMLRequest/SAMLResponse.
  saml-kit help [COMMAND]                  # Describe available commands or one specific command
  saml-kit metadata SUBCOMMAND ...ARGS     # Work with SAML Metadata.
  saml-kit version                         # Display the current version
  saml-kit xmldsig SUBCOMMAND ...ARGS      # Check XML digital signatures.
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/saml-kit/saml-kit-cli.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
