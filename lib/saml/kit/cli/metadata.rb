module Saml
  module Kit
    module Cli
      class Metadata < Thor
        desc "register url", "Registers the Metadata from the remote url."
        def register(url)
          say registry.register_url(url).to_xml(pretty: true), :green
        end

        private

        def registry
          Saml::Kit.registry
        end
      end
    end
  end
end
