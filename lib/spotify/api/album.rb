module Spotify
  module API

    class Album < Spotify::API::Base

      #
      # API endpoint for albums.
      #
      ALBUMS_URL = "#{BASE_URL}albums"

      #
      # Gets an album.
      #
      # @param [Hash] args the search arguments.
      # @option [Fixnum] :timeout the max time a request can take.
      # @option [Fixnum] :retries the number of retries if necessary.
      #
      # @return [Spotify::Models::Album] the extracted album.
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
      # @return [Spotify::Models::Album] the extracted album.
      #
      def self.search_by_ids(args = {})
        if args[:ids].present?
          args[:ids] = [args[:ids]].flatten.join(',')
        end

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
      # @return [Spotify::Models::Album] the extracted album.
      #
      def self.tracks(args = {})
        service_params = args.slice(:timeout, :retries)
        args           = args.slice(:id, :limit, :offset, :market)

        self.new(service_params).tracks(args)
      end

      #
      # Gets an album.
      #
      # @param [Hash] args the search arguments.
      # @option [String] :id the album id.
      #
      # @return [Spotify::Models::Album] the extracted album.
      #
      def search_by_id(args = {})
        url = ALBUMS_URL + '/' + args[:id].to_s

        get(url)

        response = body

        unless response["error"]
          response = Spotify::Models::Album.new(response)
        end

        response
      end

      #
      # Gets several albums.
      #
      # @param [Hash] args the search arguments.
      # @option [String] :ids the artists ids between ",".
      #
      # @return [Array<Spotify::Models::Album>] an array containing
      #   the extracted albums.
      #
      def search_by_ids(args = {})
        get(ALBUMS_URL, args)

        response = body

        unless response["error"]
          response = response["albums"].map do |album|
            Spotify::Models::Album.new(album)
          end
        end

        response
      end

      def tracks(args = {})
        url    = ALBUMS_URL + '/' + args[:id] + '/tracks'
        params = args.slice(:limit, :offset, :market)

        get(url, params)

        response = body

        unless response["error"]
          klass    = Spotify::Models::Track
          response = Spotify::Models::Paging.new(response, klass)
        end

        response
      end

    end

  end

end
