module Spotify

  module Models

    class Full::User < Models::User

      attr_reader :birthdate, :country, :email, :product

      #
      # Sets the arguments to its variables.
      #
      # @param [Hash] args the arguments that will be placed on each variable.
      #
      # @return [Full::Artist] a full user object.
      #
      def initialize(args = {})
        super(args)

        args = Hash(args).with_indifferent_access

        @birthdate = args[:birthdate]
        @country   = args[:country]
        @email     = args[:email]
        @product   = args[:product]
      end

    end

  end

end
