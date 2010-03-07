module Fog
  module AWS
    class EC2

      def images
        Fog::AWS::EC2::Images.new(:connection => self)
      end

      class Images < Fog::Collection

        attribute :image_id

        model Fog::AWS::EC2::Image

        def initialize(attributes)
          @image_id ||= []
          super
        end

        def all(image_id = @image_id)
          @image_id = image_id
          data = connection.describe_images('ImageId' => image_id).body
          load(data['imagesSet'])
        end

        def get(image_id)
          if image_id
            all(image_id).first
          end
        rescue Excon::Errors::BadRequest
          nil
        end
      end

    end
  end
end
