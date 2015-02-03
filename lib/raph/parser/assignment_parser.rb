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
      def initialize(args)
        @args = args
      end

      def parse
        assgs = []
        @args.each do |a|
          assgs << a if assignment? a
        end
        assgs
      end

      private

      def assignment?(option)
        option.include?('=')\
        && !option.start_with?('=')\
        && !option.end_with?('=')
      end
    end
  end
end
