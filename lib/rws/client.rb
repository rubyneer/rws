# frozen_string_literal: true

module RWS
  class Client
    attr_reader :io

    def initialize(io)
      @io = io
    end

    def send_response(response)
      io.print(response.to_s)
    end

    def close
      io.close
    end
  end
end
