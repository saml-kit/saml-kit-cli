module Saml
  module Kit
    module Cli
      class XmlDigitalSignature < Thor
        desc "verify file", "Verify if the contents of a file has a valid signature."
        def verify(file)
          path = File.expand_path(file)
          say "Attempting to read #{path}..."
          content = IO.read(path)
          document = ::Xml::Kit::Document.new(content)

          if document.valid?
            say_status :success, "#{file} is valid", :green
          else
            document.errors.full_messages.each do |error|
              say_status :error, error, :red
            end
          end
        end
      end
    end
  end
end
