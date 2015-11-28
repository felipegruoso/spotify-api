module Spotify
  module API

    class User < Spotify::API::Base

      #
      # API endpoint for users.
      #
      USERS_URL = "#{BASE_URL}users"

      #
      # Gets an user.
      #
      # @param [Hash] args the search arguments.
      # @option [Fixnum] :timeout the max time a request can take.
      # @option [Fixnum] :retries the number of retries if necessary.
      #
      # @return [Public::User] the extracted user.
      #
      def self.search_by_id(args = {})
        service_params = args.slice(:timeout, :retries)
        args           = args.slice(:id)

        self.new(service_params).search_by_id(args)
      end

      #
      # Gets a track.
      #
      # @param [Hash] args the search arguments.
      # @option [String] :id the track id.
      # @option [String] :market the market.
      #
      # @return [Public::User] the extracted user.
      #
      def search_by_id(args = {})
        get(USERS_URL + '/' + args[:id].to_s)

        response = body

        unless response["error"]
          response = Spotify::Models::Simplified::User.new(response)
        end

        response
      end

      #
      # Parses the response to JSON to get more flexible.
      #
      # @return [Hash] the parsed response.
      #
      def body
        JSON.parse(response)
      rescue
        { 'error' => Spotify::API::Errors::PARSER_ERROR }
      end

    end

  end
end
