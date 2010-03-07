module Fog
  class Slicehost

    def servers
      Fog::Slicehost::Servers.new(:connection => self)
    end

    class Servers < Fog::Collection

      model Fog::Slicehost::Server

      def all
        data = connection.get_slices.body['slices']
        load(data)
      end

      def get(server_id)
        if server_id && server = connection.get_slice(server_id).body
          new(server)
        elsif !server_id
          nil
        end
      rescue Excon::Errors::Forbidden
        nil
      end

    end

  end
end
