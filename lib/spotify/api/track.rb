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
      # @param [Hash] args the search arguments.
      # @option [Fixnum] :timeout the max time a request can take.
      # @option [Fixnum] :retries the number of retries if necessary.
      #
      # @return [Spotify::Models::Track] the extracted track.
      #
      def self.search_by_id(args = {})
        service_params = args.slice(:timeout, :retries)
        args           = args.slice(:id, :market)

        self.new(service_params).search_by_id(args)
      end

      #
      # Gets several tracks.
      #
      # @param [Hash] args the search arguments.
      # @option [Fixnum] :timeout the max time a request can take.
      # @option [Fixnum] :retries the number of retries if necessary.
      #
      # @return [Array<Spotify::Models::Track>] an array containing
      #   the extracted tracks.
      #
      def self.search_by_ids(args = {})
        args[:ids]     ||= []
        args[:ids]     = args[:ids].join(',')
        service_params = args.slice(:timeout, :retries)
        args           = args.slice(:ids, :market)

        self.new(service_params).search_by_ids(args)
      end

      #
      # Gets a track.
      #
      # @param [Hash] args the search arguments.
      # @option [String] :id the track id.
      # @option [String] :market the market.
      #
      # @return [Spotify::Models::Track] the extracted track.
      #
      def search_by_id(args = {})
        get(TRACKS_URL + '/' + args[:id].to_s, args.slice(:market))

        response = body

        unless response["error"]
          response = Spotify::Models::Track.new(response)
        end

        response
      end

      #
      # Gets several tracks.
      #
      # @param [Hash] args the search arguments.
      # @option [String] :ids the tracks ids between ",".
      # @option [String] :market the market.
      #
      # @return [Array<Spotify::Models::Track>] an array containing
      #   the extracted tracks.
      #
      def search_by_ids(args = {})
        get(TRACKS_URL, args)

        response = body

        unless response["error"]
          response = response["tracks"].map do |track|
            Spotify::Models::Track.new(track)
          end
        end

        response
      end

    end
  end
end
