# frozen_string_literal: true

App = lambda do |env|
  puts env[:request].url

  [
    200,
    { 'Content-Type' => 'text/html' },
    [
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
  ]
end

run App
