module Spotify

  module Models

    class Error

      attr_reader :status, :message

      #
      # Identifies that the error is returned from some request.
      #
      DEFAULT = :default

      #
      # Defines the text and status for each message known.
      #
      ERRORS = {
        timeout: {
          status:  700,
          message: "Timed out."
        },
        unexpected_error: {
          status: 710,
          message: "Unexpected error."
        },
        max_retries: {
          status: 720,
          message: "Max retries exceeded."
        },
        not_available: {
          status: 730,
          message: "This feature is not available yet."
        },
        parser_error: {
          status: 740,
          message: "Something went wrong. Please verify the parameters"
        }
      }

      #
      # Creates the message.
      #
      # @param [Hash] type the type of the message to be shown.
      #
      # @return [Parsers::Error] a message to be shown to the user.
      #
      def initialize(type, args = {})
        if type == DEFAULT
          error = {
            status:  args[:status],
            message: args[:message]
          }
        else
          error = ERRORS[type]
        end

        @status  = error[:status]
        @message = error[:message]
      end

      #
      # Creates an error representing a timeout error.
      #
      # @return [Parsers::Error] a message to be shown to the user.
      #
      def self.timeout
        self.new(:timeout)
      end

      #
      # Creates an error representing an unexpected error.
      #
      # @return [Parsers::Error] a message to be shown to the user.
      #
      def self.unexpected_error
        self.new(:unexpected_error)
      end

      #
      # Creates an error representing that the retries limit was reached.
      #
      # @return [Parsers::Error] a message to be shown to the user.
      #
      def self.max_retries
        self.new(:max_retries)
      end

      #
      # Creates an error representing that the requested feature is not
      # available yet.
      #
      # @return [Parsers::Error] a message to be shown to the user.
      #
      def self.not_available
        self.new(:not_available)
      end

      #
      # Creates an error representing a parser error.
      #
      # @return [Parsers::Error] a message to be shown to the user.
      #
      def self.parser_error
        self.new(:parser_error)
      end

      #
      # Creates an error representing the site response error.
      #
      # @return [Parsers::Error] a message to be shown to the user.
      #
      def self.default(args = {})
        args = Hash(args).with_indifferent_access

        self.new(:default, args)
      end

    end

  end

end
