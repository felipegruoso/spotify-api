module Spotify
  module API

    class Album < Spotify::API::Base

      #
      # API endpoint for albums.
      #
      ALBUMS_URL = "#{BASE_URL}albums"

      #
      # Gets the albums related to the given parameters.
      #
      # @param [Hash] args the search arguments.
      # @option [Fixnum] :timeout the max time a request can take.
      # @option [Fixnum] :retries the number of retries if necessary.
      #
      # @return [Spotify::Models::Paging] the extracted albums.
      #
      def self.search(args = {})
        args[:type] = :album

        service_params = args.slice(:timeout, :retries)
        args           = args.slice(:q, :market, :type, :limit, :offset)

        self.new(service_params).search(args)
      end

      #
      # Gets an album.
      #
      # @param [Hash] args the search arguments.
      # @option [Fixnum] :timeout the max time a request can take.
      # @option [Fixnum] :retries the number of retries if necessary.
      #
      # @return [Full::Album] the extracted album.
      #
      def self.search_by_id(args = {})
        service_params = args.slice(:timeout, :retries)
        args           = args.slice(:id)

        self.new(service_params).search_by_id(args)
      end

      #
      # Gets an album.
      #
      # @param [Hash] args the search arguments.
      # @option [Fixnum] :timeout the max time a request can take.
      # @option [Fixnum] :retries the number of retries if necessary.
      #
      # @return [Array<Full::Album>] the extracted album.
      #
      def self.search_by_ids(args = {})
        args[:ids] = Array(args[:ids]).join(',')

        service_params = args.slice(:timeout, :retries)
        args           = args.slice(:ids)

        self.new(service_params).search_by_ids(args)
      end

      #
      # Gets an album.
      #
      # @param [Hash] args the search arguments.
      # @option [Fixnum] :timeout the max time a request can take.
      # @option [Fixnum] :retries the number of retries if necessary.
      #
      # @return [Full::Album] the extracted album.
      #
      def self.tracks(args = {})
        service_params = args.slice(:timeout, :retries)
        args           = args.slice(:id, :limit, :offset, :market)

        self.new(service_params).tracks(args)
      end

      #
      # Gets the albums related to the given parameters.
      #
      # @param [Hash] args the search arguments.
      # @option [Fixnum] :timeout the max time a request can take.
      # @option [Fixnum] :retries the number of retries if necessary.
      #
      # @return [Spotify::Models::Paging] the extracted albums.
      #
      def search(args = {})
        if args[:market].to_s.to_sym == FROM_TOKEN
          # TODO: Authorization.
          return Spotify::API::Errors::NOT_AVAILABLE
        end

        get(SEARCH_URL, args)

        response = body

        unless response["error"]
          klass    = Spotify::Models::Simplified::Album
          response = Spotify::Models::Paging.new(response["albums"], klass)
        end

        response
      end

      #
      # Gets an album.
      #
      # @param [Hash] args the search arguments.
      # @option [String] :id the album id.
      #
      # @return [Full::Album] the extracted album.
      #
      def search_by_id(args = {})
        url = ALBUMS_URL + '/' + args[:id].to_s

        get(url)

        response = body

        unless response["error"]
          response = Spotify::Models::Full::Album.new(response)
        end

        response
      end

      #
      # Gets several albums.
      #
      # @param [Hash] args the search arguments.
      # @option [String] :ids the artists ids between ",".
      #
      # @return [Array<Full::Album>] an array containing
      #   the extracted albums.
      #
      def search_by_ids(args = {})
        get(ALBUMS_URL, args)

        response = body

        unless response["error"]
          response = response["albums"].map do |album|
            Spotify::Models::Full::Album.new(album)
          end
        end

        response
      end

      #
      # Gets the album's tracks.
      #
      # @param [Hash] args the search arguments.
      #
      # @return [Paging] an array containing album's tracks.
      #
      def tracks(args = {})
        url    = ALBUMS_URL + '/' + args[:id] + '/tracks'
        params = args.slice(:limit, :offset, :market)

        get(url, params)

        response = body

        unless response["error"]
          klass    = Spotify::Models::Simplified::Track
          response = Spotify::Models::Paging.new(response, klass)
        end

        response
      end

    end

  end

end
