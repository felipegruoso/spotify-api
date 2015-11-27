module Spotify

  module Models

    #
    # This class is kept only to provide a better visualization.
    #
    class Simplified::Track < Models::Track

      #
      # Sets the arguments to its variables.
      #
      # @param [Hash] args the arguments that will be placed on each variable.
      #
      # @return [Simplified::Track] a simplified track object.
      #
      def initialize(args = {}); super(args); end;

    end

  end

end
