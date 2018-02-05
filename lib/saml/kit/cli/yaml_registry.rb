module Saml
  module Kit
    module Cli
      class YamlRegistry < ::Saml::Kit::DefaultRegistry
        def initialize(path)
          @items = YAML::Store.new(path)
        end

        def register(metadata)
          @items.transaction do
            @items[metadata.entity_id] = metadata.to_xml
          end
          metadata
        end

        def metadata_for(entity_id)
          Saml::Kit::Metadata.from(@items[entity_id])
        end
      end
    end
  end
end