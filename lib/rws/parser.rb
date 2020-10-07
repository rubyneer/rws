# frozen_string_literal: true

module RWS
  class Parser
    def self.parse_start_line(io)
      start_line = io.gets
      start_line.split(' ')
    end

    def self.parse_headers(io)
      headers = {}

      loop do
        header_line = io.gets.strip
        break if header_line.empty?

        name, value = header_line.split(': ')
        headers[name] = value
      end

      headers
    end
  end
end
