require 'raph/parser/assignment_parser'

module Raph
  module Parser
    # Considers option as assignment if and only if
    # it has an assignment character (=) between
    # option key and option value.
    #
    # Assumes that each option doesn't have spaces.
    #
    # Example of assignments:
    #   'h=one' '-assg=two' '--config=my-file'
    #
    # Example of non-assignments:
    #   '-h' '-h=' 'h=' '=' '--config='
    #
    class AssignmentParser < BaseParser
      def parse(args)
        assgs = {}
        args.each do |a|
          if assignment? a
            kv = a.split('=')
            k = to_underscored_sym(kv.first)
            v = kv.last
            assgs[k] = v
          end
        end
        assgs
      end

      def assignment?(option)
        option.count('=') == 1 &&
          !option.start_with?('=') &&
          !option.end_with?('=')
      end
    end
  end
end
