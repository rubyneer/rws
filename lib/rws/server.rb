# frozen_string_literal: true

require 'socket'

require 'rws'
require 'rws/client'
require 'rws/configuration'
require 'rws/parser'
require 'rws/response'
require 'rws/request'

module RWS
  class Server
    DEFAULT_HOST = '0.0.0.0'
    DEFAULT_PORT = 7890

    def initialize(host: nil, port: nil)
      @host = host || DEFAULT_HOST
      @port = port || DEFAULT_PORT
      @config = RWS::Configuration.new.load
    end

    def run
      TCPServer.open(@host, @port) do |server|
        puts "RWS version #{RWS::VERSION} started, host: #{@host}, port: #{@port}"
        handle_clients(server)
      rescue Interrupt
        shutdown
      end
    end

    private

    def handle_clients(server)
      loop do
        client = get_client(server)
        break unless client

        request = handle_request(client)
        response = RWS::Response.new({ request: request }, @config[:app]).build
        client.send_response(response)

        client.close
      end
    end

    def get_client(server)
      io = server.accept
      return unless io

      RWS::Client.new(io)
    end

    def handle_request(client)
      request = RWS::Request.new(client).handle!

      puts "[#{Time.now}] #{request.method} '#{request.url}'"
      puts 'Headers:'
      puts request.headers.map { |header, value| "\t#{header}: #{value}" }.join("\n")

      request
    end

    def shutdown
      puts "\nServer is down"

      exit 0
    end
  end
end
