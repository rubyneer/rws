# frozen_string_literal: true

require 'spec_helper'

require 'rws/response'
require 'rws/request'

RSpec.describe RWS::Response do
  describe '#build' do
    subject(:build_response) { described_class.new(env, app).build }

    let(:env) { { request: request } }
    let(:request) { instance_double(RWS::Request) }

    let(:app) do
      ->(_env) { [200, { 'Content-Type' => 'text/html' }, html] }
    end
    let(:html) do
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
    end

    specify do
      response = build_response

      expect(response).to eq(
        <<~"STRING"
          HTTP/1.1 200\r
          Content-Type: text/html\r
          \r
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
        STRING
      )
    end
  end
end
