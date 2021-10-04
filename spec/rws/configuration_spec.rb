# frozen_string_literal: true

require 'spec_helper'

require 'rws/configuration'

RSpec.describe RWS::Configuration do
  describe '#load' do
    subject(:configuration) { described_class.new }

    specify do
      expect(configuration.load).to include(
        app: respond_to(:call)
      )
    end
  end
end
