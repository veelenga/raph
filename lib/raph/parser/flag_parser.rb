require 'raph/parser/base_parser'

module Raph
  module Parser
    # Considers option as flag if and only if
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
    class FlagParser < BaseParser
      def parse(args)
        flags = []
        args.each do |a|
          flags << to_underscored_sym(a) if flag? a
        end
        flags
      end

      def flag?(option)
        !!(option =~ /^-[\w]$/ || option =~ /^--[\w][\w-]+$/)
      end
    end
  end
end
