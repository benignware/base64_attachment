require 'mimemagic'

module Base64Attachment
  module HasAttachedBase64
    
    extend ActiveSupport::Concern
 
    included do
    end
 
    module ClassMethods
      def has_attached_base64(attribute, options = {})

        options[:content_type]||= nil
        options[:original_filename]||= nil
        
        content_type = options[:content_type]
        original_filename = options[:original_filename]
        
        method_name = "import_" + attribute.to_s + "_base64"
        base64_attribute = attribute.to_s + "_base64"
        before_validation method_name.to_sym
        attr_accessor base64_attribute.to_sym
        define_method "#{method_name}" do 
          if self.respond_to?(base64_attribute)
            encoded = self.send(base64_attribute).to_s
            
            if (encoded != nil && encoded.length > 0)
              
              # decode base64 string
              decoded = Base64.decode64(encoded)
              if content_type == nil || original_filename == nil
                # try to get mime type by magic numbers  
                mime = MimeMagic.by_magic(decoded)
                if content_type == nil
                  content_type = mime.to_s
                end
                if content_type != nil && original_filename == nil
                  original_filename = attribute.to_s + "." + mime.extensions.first
                end
              end
              
              # if content_type == nil || original_filename == nil
                # # if present, try using imagemagick to get mime type
                # begin
                  # img = Magick::Image.from_blob(decoded).first
                  # if img != nil
                    # file_extension = img.format.downcase
                    # if content_type == nil
                      # content_type = "image/" + file_extension
                    # end
                    # if original_filename == nil
                      # original_filename = attribute.to_s + "." + file_extension
                    # end
                  # end
                # rescue
                  # # could not determine type
                # end
              # end
              
              StringIO.open(decoded) do |data|
                data.class.class_eval { attr_accessor :original_filename, :content_type }
                data.content_type = content_type
                data.original_filename = original_filename
                self.send(attribute.to_s  + "=", data)
              end
            end
          end
          
        end 
      end
    end
  end
end
 
ActiveRecord::Base.send :include, Base64Attachment::HasAttachedBase64