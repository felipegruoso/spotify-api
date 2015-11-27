module Spotify

  module Models

    class Album

      attr_reader :album_type, :available_markets, :external_urls,
        :genres, :href, :id, :images, :name, :type, :uri

      #
      # Sets the arguments to its variables.
      #
      # @param [Hash] args the arguments that will be placed on each variable.
      #
      # @return [Album] an album object.
      #
      def initialize(args = {})
        args = Hash(args).with_indifferent_access

        # Arrays
        images = Array(args[:images]).map { |i| Spotify::Models::Image.new(i) }

        # Objects
        external_urls = Spotify::Models::ExternalURL.new(args[:external_urls])

        @album_type             = args[:album_type]
        @available_markets      = args[:available_markets]
        @external_urls          = external_urls
        @genres                 = args[:genres]
        @href                   = args[:href]
        @id                     = args[:id]
        @images                 = images
        @name                   = args[:name]
        @type                   = args[:type]
        @uri                    = args[:uri]
      end

    end

  end

end
