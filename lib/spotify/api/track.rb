module Spotify
  module API

    class Track < Spotify::API::Base

      #
      # API endpoint for tracks.
      #
      TRACKS_URL = "#{BASE_URL}tracks"

      #
      # Gets the tracks related to the given parameters.
      #
      # @param [Hash] args the search arguments.
      # @option [Fixnum] :timeout the max time a request can take.
      # @option [Fixnum] :retries the number of retries if necessary.
      #
      # @return [Spotify::Models::Paging] the extracted tracks.
      #
      def self.search(args = {})
        args[:type] = :track

        service_params = args.slice(:timeout, :retries)
        args           = args.slice(:q, :market, :type, :limit, :offset)

        self.new(service_params).search(args)
      end

      #
      # Gets a track.
      #
      # @param [Hash] args the search arguments.
      # @option [Fixnum] :timeout the max time a request can take.
      # @option [Fixnum] :retries the number of retries if necessary.
      #
      # @return [Full::Track] the extracted track.
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
      # @return [Array<Full::Track>] an array containing
      #   the extracted tracks.
      #
      def self.search_by_ids(args = {})
        args[:ids] = Array(args[:ids]).join(',')

        service_params = args.slice(:timeout, :retries)
        args           = args.slice(:ids, :market)

        self.new(service_params).search_by_ids(args)
      end

      #
      # Gets the tracks related to the given parameters.
      #
      # @param [Hash] args the search arguments.
      # @option [Fixnum] :timeout the max time a request can take.
      # @option [Fixnum] :retries the number of retries if necessary.
      #
      # @return [Spotify::Models::Paging] the extracted tracks.
      #
      def search(args = {})
        if args[:market].to_s.to_sym == FROM_TOKEN
          # TODO: Authorization.
          return Spotify::API::Errors::NOT_AVAILABLE
        end

        get(SEARCH_URL, args)

        define_response do
          klass = Spotify::Models::Full::Track

          Spotify::Models::Paging.new(response["tracks"], klass)
        end
      end

      #
      # Gets a track.
      #
      # @param [Hash] args the search arguments.
      # @option [String] :id the track id.
      # @option [String] :market the market.
      #
      # @return [Full::Track] the extracted track.
      #
      def search_by_id(args = {})
        get(TRACKS_URL + '/' + args[:id].to_s, args.slice(:market))

        define_response do
          Spotify::Models::Full::Track.new(response)
        end
      end

      #
      # Gets several tracks.
      #
      # @param [Hash] args the search arguments.
      # @option [String] :ids the tracks ids between ",".
      # @option [String] :market the market.
      #
      # @return [Array<Full::Track>] an array containing
      #   the extracted tracks.
      #
      def search_by_ids(args = {})
        get(TRACKS_URL, args)

        define_response do
          response["tracks"].map do |track|
            Spotify::Models::Full::Track.new(track)
          end
        end
      end

    end
  end
end
