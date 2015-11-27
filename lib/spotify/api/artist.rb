module Spotify
  module API

    class Artist < Spotify::API::Base

      #
      # API endpoint for artists.
      #
      ARTISTS_URL = "#{BASE_URL}artists"

      #
      # Gets the artists related to the given parameters.
      #
      # @param [Hash] args the search arguments.
      # @option [Fixnum] :timeout the max time a request can take.
      # @option [Fixnum] :retries the number of retries if necessary.
      #
      # @return [Spotify::Models::Paging] the extracted artists.
      #
      def self.search(args = {})
        args[:type] = :artist

        service_params = args.slice(:timeout, :retries)
        args           = args.slice(:q, :market, :type, :limit, :offset)

        self.new(service_params).search(args)
      end

      #
      # Gets an artist.
      #
      # @param [Hash] args the search arguments.
      # @option [Fixnum] :timeout the max time a request can take.
      # @option [Fixnum] :retries the number of retries if necessary.
      #
      # @return [Full::Artist] the extracted artist.
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
      # @return [Array<Full::Artist>] an array containing
      #   the extracted artists.
      #
      def self.search_by_ids(args = {})
        args[:ids] = Array(args[:ids]).join(',')

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
      # @return [Array<Full::Track>] an array containing
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
      # @return [Array<Full::Artist>] an array containing
      #   the extracted artist's related artists.
      #
      def self.related_artists(args = {})
        args           = args.slice(:id)
        service_params = args.slice(:timeout, :retries)

        self.new(service_params).related_artists(args)
      end

      #
      # Get an artist's albums.
      #
      # @param [Hash] args the search arguments.
      # @option [Fixnum] :timeout the max time a request can take.
      # @option [Fixnum] :retries the number of retries if necessary.
      #
      # @return [Paging] an array containing the extracted artist's albums.
      #
      def self.albums(args = {})
        args[:album_type] = Array(args[:album_type]).join(',')

        args           = args.slice(:id, :album_type, :market, :limit, :offset)
        service_params = args.slice(:timeout, :retries)

        self.new(service_params).albums(args)
      end

      #
      # Gets the artists related to the given parameters.
      #
      # @param [Hash] args the search arguments.
      # @option [Fixnum] :timeout the max time a request can take.
      # @option [Fixnum] :retries the number of retries if necessary.
      #
      # @return [Spotify::Models::Paging] the extracted artists.
      #
      def search(args = {})
        if args[:market].to_s.to_sym == FROM_TOKEN
          # TODO: Authorization.
          return Spotify::API::Errors::NOT_AVAILABLE
        end

        get(SEARCH_URL, args)

        response = body

        unless response["error"]
          klass    = Spotify::Models::Full::Artist
          response = Spotify::Models::Paging.new(response["artists"], klass)
        end

        response
      end

      #
      # Gets an artist.
      #
      # @param [Hash] args the search arguments.
      # @option [String] :id the artist id.
      #
      # @return [Full::Artist] the extracted artist.
      #
      def search_by_id(args = {})
        url = ARTISTS_URL + '/' + args[:id].to_s

        get(url)

        response = body

        unless response["error"]
          response = Spotify::Models::Full::Artist.new(response)
        end

        response
      end

      #
      # Gets several artists.
      #
      # @param [Hash] args the search arguments.
      # @option [String] :ids the artists ids between ",".
      #
      # @return [Array<Full::Artist>] an array containing
      #   the extracted artists.
      #
      def search_by_ids(args = {})
        get(ARTISTS_URL, args)

        response = body

        unless response["error"]
          response = response["artists"].map do |artist|
            Spotify::Models::Full::Artist.new(artist)
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
      # @return [Array<Full::Track>] an array containing
      #   the extracted artist's top tracks.
      #
      def top_tracks(args = {})
        url    = ARTISTS_URL + '/' + args[:id].to_s + '/top-tracks'
        params = args.slice(:country)

        get(url, params)

        response = body

        unless response["error"]
          response = response["tracks"].map do |track|
            Spotify::Models::Full::Track.new(track)
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
      # @return [Array<Full::Artist>] an array containing
      #   the extracted artist's related artists.
      #
      def related_artists(args = {})
        url = ARTISTS_URL + '/' + args[:id].to_s + '/related-artists'

        get(url)

        response = body

        unless response["error"]
          response = response["artists"].map do |artist|
            Spotify::Models::Full::Artist.new(artist)
          end
        end

        response
      end

      #
      # Get an artist's albums.
      #
      # @param [Hash] args the search arguments.
      # @option [Fixnum] :timeout the max time a request can take.
      # @option [Fixnum] :retries the number of retries if necessary.
      #
      # @return [Paging] an array containing the extracted artist's
      #   related artists.
      #
      def albums(args = {})
        url    = ARTISTS_URL + '/' + args[:id].to_s + '/albums'
        params = args.slice(:album_type, :market, :limit, :offset)

        get(url, params)

        response = body

        unless response["error"]
          klass    = Spotify::Models::Simplified::Album
          response = Spotify::Models::Paging.new(response, klass)
        end

        response
      end

    end

  end
end