module Saml
  module Kit
    module Cli
      class XmlDigitalSignature < Thor
        desc "verify file", "Verify if the contents of a file has a valid signature."
        method_option :format, default: "short", required: false, enum: ["short", "full"]
        def verify(file)
          format = options[:format]
          path = File.expand_path(file)
          say_status :status, "Attempting to read #{path}...", :yellow
          content = IO.read(path)
          document = ::Xml::Kit::Document.new(content)

          if document.valid?
            say_status :success, "#{file} is valid", :green
          else
            document.errors.full_messages.each do |error|
              say_status :error, error, :red
            end

            if "full" == format
              document.send(:invalid_signatures).each_with_index do |invalid_signature, index|
                say "Signature: #{index}"
                say invalid_signature.signature.to_xml(indent: 2), :red
              end
            end
          end
        end
      end
    end
  end
end
