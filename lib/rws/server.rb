# frozen_string_literal: true

require 'socket'

require 'rws'

module RWS
  class Server
    DEFAULT_HOST = '0.0.0.0'
    DEFAULT_PORT = 7890

    def initialize(host: nil, port: nil)
      @host = host || DEFAULT_HOST
      @port = port || DEFAULT_PORT
    end

    def run
      puts "RWS version #{RWS::VERSION} started, host: #{@host}, port: #{@port}"
      puts 'Server is down'
    end
  end
end
