module Spotify

  module Models

    class Track

      attr_reader :artists, :available_markets, :disc_number, :duration_ms,
        :explicit, :external_urls, :href, :id, :is_playable, :linked_from,
        :name, :preview_url, :track_number, :type, :uri

      #
      # Sets the arguments to its variables.
      #
      # @param [Hash] args the arguments that will be placed on each variable.
      #
      # @return [Track] a track object.
      #
      def initialize(args = {})
        args = Hash(args).with_indifferent_access

        # Arrays
        @artists = Array(args[:artists]).map { |a| Artist.new(a) }

        # Objects
        external_urls = Spotify::Models::ExternalURL.new(args[:external_urls])
        track_link    = Spotify::Models::TrackLink.new(args[:linked_from])

        @artists           = artists
        @available_markets = args[:available_markets]
        @disc_number       = args[:disc_number]
        @duration_ms       = args[:duration_ms]
        @explicit          = args[:explicit]
        @external_urls     = external_urls
        @href              = args[:href]
        @id                = args[:id]
        @is_playable       = args[:is_playable]
        @linked_from       = track_link
        @name              = args[:name]
        @preview_url       = args[:preview_url]
        @track_number      = args[:track_number]
        @type              = args[:type]
        @uri               = args[:uri]
      end

    end

  end

end