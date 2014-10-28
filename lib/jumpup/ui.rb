require 'colorize'

module Jumpup
  module UI
    class << self
      def header(message)
        separator = '-' * 80
        puts separator.white
        puts message if message
        yield if block_given?
      end

      def say(message)
        puts message
      end
    end
  end
end
