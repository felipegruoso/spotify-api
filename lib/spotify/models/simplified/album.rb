module Spotify

  module Models

    #
    # This class is kept only to provide a better visualization.
    #
    class Simplified::Album < Models::Album

      #
      # Sets the arguments to its variables.
      #
      # @param [Hash] args the arguments that will be placed
      #               on each variable.
      #
      # @return [Simplified::Album] a simplified album object.
      #
      def initialize(args = {}); super(args); end;

    end

  end

end
