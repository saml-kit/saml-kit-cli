module Saml
  module Kit
    module Cli
      module Commands
        class Metadata < Thor
          desc 'register url', 'Registers the Metadata from the remote url.'
          def register(url)
            say registry.register_url(url).to_xml(pretty: true), :green
          end

          desc 'list', "List each of the registered entityId's"
          def list
            if registry.count.zero?
              say('Register metadata using `saml-kit metadata register <url>`')
            end
            registry.each do |x|
              say x.entity_id, :green
            end
          end

          desc 'show entity_id', 'show the metadata associated with an entityId'
          def show(entity_id)
            metadata = registry.metadata_for(entity_id)
            if metadata
              Report.new(metadata).print(self)
            else
              say "`#{entity_id}` is not registered", :red
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
end
