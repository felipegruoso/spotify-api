module Spotify
  module API

    class Artist < Spotify::API::Base

      #
      # API endpoint for artists.
      #
      ARTISTS_URL = "#{BASE_URL}artists"

      #
      # Gets an artist.
      #
      # @param [Hash] args the search arguments.
      # @option [Fixnum] :timeout the max time a request can take.
      # @option [Fixnum] :retries the number of retries if necessary.
      #
      # @return [Spotify::Models::Artist] the extracted artist.
      #
      def self.search_by_id(args = {})
        service_params = args.slice(:timeout, :retries)
        args           = args.slice(:id)

        self.new(service_params).search_by_id(args)
      end

      #
      # Gets several artists.
      #
      # @param [Hash] args the search arguments.
      # @option [Fixnum] :timeout the max time a request can take.
      # @option [Fixnum] :retries the number of retries if necessary.
      #
      # @return [Array<Spotify::Models::Artist>] an array containing
      #   the extracted artists.
      #
      def self.search_by_ids(args = {})
        args[:ids]     ||= []
        args[:ids]     = args[:ids].join(',')
        service_params = args.slice(:timeout, :retries)
        args           = args.slice(:ids)

        self.new(service_params).search_by_ids(args)
      end

      #
      # Get an artist's top tracks.
      #
      # @param [Hash] args the search arguments.
      # @option [Fixnum] :timeout the max time a request can take.
      # @option [Fixnum] :retries the number of retries if necessary.
      #
      # @return [Array<Spotify::Models::Track>] an array containing
      #   the extracted artist's top tracks.
      #
      def self.top_tracks(args = {})
        args           = args.slice(:id, :country)
        service_params = args.slice(:timeout, :retries)

        self.new(service_params).top_tracks(args)
      end

      #
      # Get an artist's related artists.
      #
      # @param [Hash] args the search arguments.
      # @option [Fixnum] :timeout the max time a request can take.
      # @option [Fixnum] :retries the number of retries if necessary.
      #
      # @return [Array<Spotify::Models::Artist>] an array containing
      #   the extracted artist's related artists.
      #
      def self.related_artists(args = {})
        args           = args.slice(:id)
        service_params = args.slice(:timeout, :retries)

        self.new(service_params).related_artists(args)
      end

      #
      # Gets an artist.
      #
      # @param [Hash] args the search arguments.
      # @option [String] :id the artist id.
      #
      # @return [Spotify::Models::Artist] the extracted artist.
      #
      def search_by_id(args = {})
        get(ARTISTS_URL + '/' + args[:id].to_s)

        response = body

        unless response["error"]
          response = Spotify::Models::Artist.new(response)
        end

        response
      end

      #
      # Gets several artists.
      #
      # @param [Hash] args the search arguments.
      # @option [String] :ids the artists ids between ",".
      #
      # @return [Array<Spotify::Models::Artist>] an array containing
      #   the extracted artists.
      #
      def search_by_ids(args = {})
        get(ARTISTS_URL, args)

        response = body

        unless response["error"]
          response = response["artists"].map do |artist|
            Spotify::Models::Artist.new(artist)
          end
        end

        response
      end

      #
      # Get an artist's top tracks.
      #
      # @param [Hash] args the search arguments.
      # @option [String] :id the artist id.
      # @option [String] :country the request country.
      #
      # @return [Array<Spotify::Models::Track>] an array containing
      #   the extracted artist's top tracks.
      #
      def top_tracks(args = {})
        get(ARTISTS_URL + '/' + args[:id].to_s + '/top-tracks', args.slice(:country))

        response = body

        unless response["error"]
          response = response["tracks"].map do |track|
            Spotify::Models::Track.new(track)
          end
        end

        response
      end

      #
      # Get an artist's related artists.
      #
      # @param [Hash] args the search arguments.
      # @option [Fixnum] :timeout the max time a request can take.
      # @option [Fixnum] :retries the number of retries if necessary.
      #
      # @return [Array<Spotify::Models::Artist>] an array containing
      #   the extracted artist's related artists.
      #
      def related_artists(args = {})
        get(ARTISTS_URL + '/' + args[:id].to_s + '/related-artists')

        response = body

        unless response["error"]
          response = response["artists"].map do |artist|
            Spotify::Models::Artist.new(artist)
          end
        end

        response
      end

    end

  end
end