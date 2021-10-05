# frozen_string_literal: true

require 'rws/builder'

module RWS
  class Configuration
    DEFAULT_CONFIG_FILE = 'config.ru'

    def initialize(config_file = nil)
      @config_file = config_file || DEFAULT_CONFIG_FILE
    end

    def load
      { app: rackup_app }
    end

    private

    def rackup_app
      raise "Missing rackup file '#{@config_file}'" unless File.exist?(@config_file)

      config = File.read(@config_file)

      eval "RWS::Builder.new {\n#{config}\n}.to_app", TOPLEVEL_BINDING, @config_file, 0
    end
  end
end
