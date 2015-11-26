module Spotify

  module Models

    class ExternalURL

      def initialize(args = {})
        args = args.with_indifferent_access

        hsh = {
          spotify: args[:spotify]
        }

        hsh = hsh.reject { |_, v| v.blank? }

        if hsh.present?
          # Generates the keys dynamically
          hsh.each do |k, v|
            key   = k
            value = v

            eval("@#{key} = value")
            class_eval { attr_reader key.to_sym }
          end
        end
      end

    end

  end

end
