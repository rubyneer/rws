# frozen_string_literal: true

module RWS
  class Response
    def initialize(env, app)
      @env = env
      @app = app
    end

    def build
      status, headers, body = @app.call(@env)

      [start_line(status), prepare_headers(headers), empty_line, body].join("\r\n")
    end

    private

    def start_line(status)
      "HTTP/1.1 #{status}"
    end

    def prepare_headers(headers)
      headers.map { |name, value| "#{name}: #{value}" }.join("\n")
    end

    def empty_line
      ''
    end
  end
end
