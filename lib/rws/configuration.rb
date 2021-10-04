# frozen_string_literal: true

module RWS
  class Configuration
    def initialize
      @app = app
    end

    def load
      { app: @app }
    end

    private

    def app # rubocop:disable Metrics/MethodLength
      lambda do |_env|
        [
          200,
          { 'Content-Type' => 'text/html' },
          <<~HTML
            <!doctype html>
            <html>
              <head>
                <meta content="text/html; charset=UTF-8">
                <title>Welcome to RWS!</title>
              </head>
              <body>
                <h1>Welcome to RWS!</h1>
              </body>
            </html>
          HTML
        ]
      end
    end
  end
end
