require 'raph/parser/base_parser'
require 'raph/parser/flag_parser'
require 'raph/parser/assignment_parser'

module Raph
  module Parser
    # Grouped arguments are arguments that follows
    # a group - a specific argument. In other words
    # flags and assignments represents groups and
    # arguments followed them are grouped arguments.
    #
    # Next example:
    #   '--group1', '1', '2', '--group2', 'three'
    # has two groups (`:group1` and `:group2`) with
    # corresponding grouped arguments (['1', '2'], ['three'])
    class GroupedArgParser < BaseParser
      def initialize
        @flag_parser = FlagParser.new
        @assignment_parser = AssignmentParser.new
      end

      def parse(args)
        current_group = nil

        args.each_with_object({}) do |arg, groups|
          if group? arg
            current_group = to_underscored_sym arg
            groups[current_group] = []
          else
            groups[current_group].push(arg) if current_group
          end
        end
      end

      def group?(arg)
        @flag_parser.flag?(arg) || @assignment_parser.assignment?(arg)
      end
    end
  end
end
