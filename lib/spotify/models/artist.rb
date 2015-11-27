module Spotify

  module Models

    class Artist

      attr_reader :external_urls, :href, :id, :name, :type, :uri

      #
      # Sets the arguments to its variables.
      #
      # @param [Hash] args the arguments that will be placed on each variable.
      #
      # @return [Album] an artist object.
      #
      def initialize(args = {})
        args = Hash(args).with_indifferent_access

        # Objects
        external_urls = Spotify::Models::ExternalURL.new(args[:external_urls])

        @external_urls = external_urls
        @href          = args[:href]
        @id            = args[:id]
        @name          = args[:name]
        @type          = args[:type]
        @uri           = args[:uri]
      end

    end

  end

end
