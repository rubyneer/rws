# frozen_string_literal: true

require 'optparse'

require 'rws/server'

module RWS
  class CLI
    def initialize(argv)
      @argv = argv.dup

      @host = nil
      @port = nil

      option_parser.parse!(@argv)
    end

    def run
      RWS::Server.new(host: @host, port: @port).run
    end

    private

    def option_parser
      OptionParser.new do |option|
        option.on '--host HOST', 'Host to bind' do |arg|
          @host = arg
        end

        option.on '-p', '--port PORT', 'The TCP port to listen by server' do |arg|
          @port = arg.to_i
        end
      end
    end
  end
end
