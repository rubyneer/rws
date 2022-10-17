# frozen_string_literal: true

require 'optparse'

require 'rws/server'

module RWS
  class CLI
    def self.call(argv)
      options = { need_to_exit: false }

      option_parser(options).parse!(argv.dup)
      exit if options[:need_to_exit]

      RWS::Server.new(**options.slice(:host, :port, :config)).run
    end

    # rubocop:disable Metrics/MethodLength
    def self.option_parser(options)
      OptionParser.new do |option|
        option.on '--help', 'Print help info' do
          puts option
          options[:need_to_exit] = true
        end

        option.on '-h', '--host HOST', 'Host to bind' do |arg|
          options[:host] = arg
        end

        option.on '-p', '--port PORT', 'The TCP port to listen by server' do |arg|
          options[:port] = arg.to_i
        end

        option.on '-c', '--config FILEPATH', 'Path to rackup-compatible config file' do |arg|
          options[:config] = arg
        end

        option.on '--version', 'Current version' do
          puts RWS::VERSION
          options[:need_to_exit] = true
        end
      end
    end
    # rubocop:enable Metrics/MethodLength
  end
end
