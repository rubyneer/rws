# frozen_string_literal: true

module RWS
  class Builder
    def initialize(default_app = nil, &block)
      @app = default_app

      instance_eval(&block) if block_given?
    end

    def run(app)
      @app = app
    end

    def to_app
      @app
    end
  end
end
