module Spotify

  module Models

    class Copyright

      attr_reader :text, :type

      #
      # Sets the arguments to its variables.
      #
      # @param [Hash] args the arguments that will be placed on each variable.
      #
      # @return [Image] a copyright object.
      #
      def initialize(args = {})
        args = Hash(args).with_indifferent_access

        @text = args[:text]
        @type = args[:type]
      end

    end

  end

end
