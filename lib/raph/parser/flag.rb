module Raph
  module Parser
    # Considers option as flag if an only if
    # it's name starts with one dash and follows by
    # one word character or starts with two dashes
    # and follows by 2 or more word chacters or dashes.
    #
    # Assumes that each option doesn't have spaces.
    #
    # Example of flags:
    #   '-h' '-T' '--config'
    #
    # Example of non-flags:
    #   'option' '---option2' '--h'
    class Flag < BaseParser

      attr_reader :flags

      def initialize(args)
        @args = args
      end

      def parse
        @flags = []
        @args.each do |a|
          if flag? a
            flags << a
          end
        end
      end

      def id
        'flags'
      end

      private

      def flag?(option)
        option =~ /^-[\w]$/ or option =~ /^--[\w][\w-]+$/
      end
    end
  end
end
