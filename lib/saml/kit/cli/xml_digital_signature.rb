require 'uri'

module Saml
  module Kit
    module Cli
      class XmlDigitalSignature < Thor
        desc "verify file", "Verify if the contents of a file has a valid signature."
        method_option :format, default: "short", required: false, enum: ["short", "full"]
        def verify(file)
          format = options[:format]
          path = File.expand_path(file)

          if File.exist?(path)
            path = File.expand_path(file)
            say_status :status, "Attempting to read #{path}...", :yellow
            content = IO.read(path)
          else
            uri = URI.parse(file) rescue nil
            say_status :status, "Downloading from #{uri}...", :yellow
            content = Net::HTTP.get_response(uri).body.chomp
          end
          document = ::Xml::Kit::Document.new(content)
          say document.to_xml(pretty: true)
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
