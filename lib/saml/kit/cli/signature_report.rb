require 'uri'

module Saml
  module Kit
    module Cli
      class SignatureReport
        attr_reader :content, :format, :path

        def initialize(path, format:)
          @format = format
          @path = path
          if File.exist?(File.expand_path(path))
            @content = IO.read(File.expand_path(path))
          else
            uri = URI.parse(path)
            @content = Net::HTTP.get_response(uri).body.chomp
          end
        end

        def print(shell)
          shell.say to_xml
          return shell.say_status :success, "#{path} is valid", :green if valid?
          errors.each { |error| shell.say_status(:error, error, :red) }
          return unless full?
          invalid_signatures.each { |x| shell.say(x.to_xml(indent: 2), :red) }
        end

        private

        def document
          @document ||= ::Xml::Kit::Document.new(content)
        end

        def to_xml
          document.to_xml(pretty: true)
        end

        def valid?
          document.valid?
        end

        def full?
          format == 'full'
        end

        def errors
          document.errors.full_messages
        end

        def invalid_signatures
          document.send(:invalid_signatures).map(&:signature)
        end
      end
    end
  end
end
