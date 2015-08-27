require 'raph/parser/file_parser'
require 'raph/parser/flag_parser'
require 'raph/parser/assignment_parser'
require 'raph/parser/grouped_arg_parser'

module Raph
  #
  # Ruby Argument Parser for Humans.
  # Parses arguments using external parsers.
  #
  #   class Parser1 < BaseParser
  #     def id
  #       'parser1_result'
  #     end
  #
  #     def parse(arg)
  #       # return your parsed arguments
  #     end
  #   end
  #
  #   class Parser2 < Base
  #     def id
  #       'parser2_result'
  #     end
  #
  #     def parse(arg)
  #       # return your parsed arguments
  #     end
  #   end
  #
  #   raph = Raph.new.tap do |r|
  #     r.add_parser(Parser1.new)
  #     r.add_parser(Parser2.new)
  #     # ...
  #
  #     r.parse (arguments)
  #   end
  #
  #   puts raph.parser1_result # parsed arguments by Parser1
  #   puts raph.parser2_result # parsed arguments by Parser2
  class Raph
    #
    # Initializes Raph.
    def initialize
      @parsed = {}
      @parsers = []
    end

    #
    # Parses arguments using external parsers.
    #
    # +args+:: arguments to be parsed.
    def parse(args)
      @all = args.dup

      @parsers.each do |p|
        @parsed[p.id] = p.parse(@all)
      end
    end

    #
    # Returns all arguments.
    def all
      @all.dup
    end

    #
    # Adds new external parser to parser list.
    #
    # +parser+:: external parser.
    def add_parser(parser)
      @parsers.push parser
      define_singleton_method(parser.id) do |*args, &block|
        raise ArgumentError, 'Arguments not applicable' if args.any?
        raise ArgumentError, 'Block not applicable' if block
        @parsed[parser.id]
      end
    end
  end

  include Parser

  $raph = Raph.new.tap do |r|
    r.add_parser(FileParser.new)
    r.add_parser(FlagParser.new)
    r.add_parser(AssignmentParser.new)
    r.add_parser(GroupedArgParser.new)

    r.parse(ARGV)
  end
end
