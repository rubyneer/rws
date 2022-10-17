# frozen_string_literal: true

require 'rws/builder'

module RWS
  class Configuration
    DEFAULT_CONFIG_FILE = 'config.ru'

    def initialize(config_file = DEFAULT_CONFIG_FILE)
      @config_file = config_file
    end

    def load
      { app: rackup_app }
    end

    private

    def rackup_app
      raise "Missing rackup file '#{@config_file}'" unless File.exist?(@config_file)

      config = File.read(@config_file)
      builder = <<~"BUILDER"
        RWS::Builder.new {
          #{config}
        }.to_app
      BUILDER
      eval builder, TOPLEVEL_BINDING, __FILE__, __LINE__ # rubocop:disable Security/Eval
    end
  end
end
