# frozen_string_literal: true

module Saml
  module Kit
    module Cli
      class YamlRegistry < ::Saml::Kit::DefaultRegistry
        def initialize(path)
          @items = YAML::Store.new(path)
        end

        def register(metadata)
          with_transaction do |db|
            db[metadata.entity_id] = metadata.to_xml
          end
          metadata
        end

        def metadata_for(entity_id)
          with_transaction do |db|
            xml = db[entity_id]
            return nil if xml.nil?
            Saml::Kit::Metadata.from(xml)
          end
        end

        def each
          with_transaction do |db|
            db.roots.each do |key|
              yield metadata_for(key)
            end
          end
        end

        private

        def with_transaction
          return yield @items if @in_transaction
          @items.transaction do
            begin
              @in_transaction = true
              yield @items
            ensure
              @in_transaction = false
            end
          end
        end
      end
    end
  end
end
