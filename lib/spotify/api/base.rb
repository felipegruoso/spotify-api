require 'json'
require 'timeout'
require 'net/http'

module Spotify
  module API

    class Base

      attr_reader :response, :retries, :timeout, :url, :params, :request

      #
      # The API base URL.
      #
      BASE_URL = "https://api.spotify.com/v1/"

      #
      # The API search endpoint.
      #
      SEARCH_URL = "#{BASE_URL}search"

      #
      # The max retries limit.
      #
      MAX_RETRIES = 5

      #
      # Restrict value for market variable on search methods.
      #
      FROM_TOKEN = :from_token

      #
      # Initializes the optional arguments.
      #
      # @param [Hash] the optional arguments.
      # @option [Fixnum] :timeout the max time a request can take.
      # @option [Fixnum] :retries the number of retries if necessary.
      #
      def initialize(args = {})
        @args    = args.except(:timeout, :retries)
        @timeout = args[:timeout].to_i
        @retries = args[:retries].to_i
      end

      #
      # Performs a request on the given url with its arguments.
      #
      # @param [String] url the request API url.
      # @param [Hash] params the request arguments.
      #
      def get(url, params = {})
        @url     = url
        @params  = params
        @request = prepare_request

        make_request
      end

      #
      # Performs the request respecting the given timeout.
      #
      # @param [Proc] block a block of code to perform the request.
      #
      def run_with_timeout(&block)
        Timeout.timeout(@timeout) do
          yield
        end
      end

      #
      # Prepares the Proc instructions to perform the request.
      #
      def prepare_request
        lambda do
          sleep(3)
          uri       = URI(@url)
          uri.query = URI.encode_www_form(@params)
          @response = Net::HTTP.get(uri)
        end
      end

      #
      # Handles the request behavior.
      #
      # @param [Fixnum] attempts the current attempt number.
      #
      def make_request(attempts = 0)
        @attempts = attempts

        if attempts > MAX_RETRIES || attempts > @retries
          set_response(Spotify::Models::Error.max_retries, true)

        else
          begin
            if @timeout > 0
              run_with_timeout { request.call }
            else
              request.call
            end

          rescue Timeout::Error
            set_response(Spotify::Models::Error.timeout)
          rescue Exception => e
            puts e.message
            puts e.backtrace
            set_response(Spotify::Models::Error.unexpected_error)
          end
        end

      end

      #
      # Sets the response in case of something goes wrong during the
      # extraction process.
      #
      # @param [String] error the raised error during the extraction.
      # @param [Boolean] force if should return error independent of retries.
      #
      def set_response(error, force = false)
        if force == false && @retries > 0
          make_request(@attempts + 1)
        else
          @response = { error: error }.to_json
        end
      end

      #
      # Parses the response to JSON to get more flexible.
      #
      # @return [Hash] the parsed response.
      #
      def body
        @response = JSON.parse(response)
      end

      def define_response(&block)
        response = body

        # The if statement covers a case for Users requests.
        if response.class != Spotify::Models::Error
          if response['error']
            response = Spotify::Models::Error.default(response['error'])
          else
            response = yield
          end
        end

        response
      end

    end

  end
end
