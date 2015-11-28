module Spotify

  module Models

    class User

      attr_reader :display_name, :external_urls, :followers, :href,
        :id, :images, :type, :uri

      #
      # Sets the arguments to its variables.
      #
      # @param [Hash] args the arguments that will be placed on each variable.
      #
      # @return [User] an user object.
      #
      def initialize(args = {})
        args = Hash(args).with_indifferent_access

        # Array
        images = Array(args[:images]).map { |i| Spotify::Models::Image.new(i) }

        # Objects
        external_urls = Spotify::Models::ExternalURL.new(args[:external_urls])
        follower      = Spotify::Models::Follower.new(args[:followers])

        @display_name  = args[:display_name]
        @external_urls = external_urls
        @followers     = follower
        @href          = args[:href]
        @id            = args[:id]
        @images        = images
        @type          = args[:type]
        @uri           = args[:uri]
      end

    end

  end

end
