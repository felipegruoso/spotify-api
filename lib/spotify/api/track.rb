module Spotify
  module API

    class Track < Spotify::API::Base

      #
      # API endpoint for tracks.
      #
      TRACKS_URL = "#{BASE_URL}tracks"

      #
      # Gets a track.
      #
      # @param [Hash] args the search arguments
      # @option [Fixnum] :timeout the max time a request can take.
      # @option [Fixnum] :retries the number of retries if necessary.
      #
      # @return [Spotify::Models::Track] the extracted track.
      #
      def self.search_by_id(args = {})
        self.new.search_by_id(args[:id])
      end

      #
      # Gets several tracks.
      #
      # @param [Hash] args the search arguments
      # @option [Fixnum] :timeout the max time a request can take.
      # @option [Fixnum] :retries the number of retries if necessary.
      #
      # @return [Array<Spotify::Models::Track>] an array containing
      #   the extracted tracks.
      #
      def self.search_by_ids(args = {})
        self.new.search_by_ids(args[:ids].join(','))
      end

      #
      # Gets a track.
      #
      # @param [Hash] id the track id.
      #
      # @return [Spotify::Models::Track] the extracted track.
      #
      def search_by_id(id)
        get(TRACKS_URL + '/' + id)

        response = body

        unless response[:error]
          response = Spotify::Models::Track.new(response)
        end

        response
      end

      #
      # Gets several tracks.
      #
      # @param [Hash] ids the tracks ids between ",".
      #
      # @return [Array<Spotify::Models::Track>] an array containing
      #   the extracted tracks.
      #
      def search_by_ids(ids)
        get(TRACKS_URL, { ids: ids })

        response = body

        unless response[:error]
          response = response["tracks"].map do |track|
            Spotify::Models::Track.new(track)
          end
        end

        response
      end

    end
  end
end
