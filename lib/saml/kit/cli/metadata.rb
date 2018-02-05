module Saml
  module Kit
    module Cli
      class Metadata < Thor
        desc "register url", "Registers the Metadata from the remote url."
        def register(url)
          say registry.register_url(url).to_xml(pretty: true), :green
        end

        desc "list", "List each of the registered entityId's"
        def list
          registry.each do |x|
            say x.entity_id, :green
          end
        end

        private

        def registry
          Saml::Kit.registry
        end
      end
    end
  end
end
