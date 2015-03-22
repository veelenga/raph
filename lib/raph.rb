require 'raph/parser/file_parser'
require 'raph/parser/flag_parser'
require 'raph/parser/assignment_parser'

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
        @parsed[p.id.to_sym] = p.parse(@all)
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
    end

    def method_missing(method_sym, *arguments, &block)
      # TODO: do not accept any arguments or block
      if has_attribute? method_sym
        get_attribute_value method_sym
      else
        super
      end
    end

    private

    #
    # Returns true if this class has dynamic argument +arg+.
    def has_attribute?(arg)
      @parsed.include? arg
    end

    #
    # Returns value of dynamic argument +arg+
    def get_attribute_value(arg)
      @parsed[arg]
    end
  end

  include Parser

  $raph = Raph.new.tap do |r|
    r.add_parser(FileParser.new)
    r.add_parser(FlagParser.new)
    r.add_parser(AssignmentParser.new)

    r.parse(ARGV)
  end
end
