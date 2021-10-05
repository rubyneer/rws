# frozen_string_literal: true

require 'spec_helper'

require 'rws/builder'

RSpec.describe RWS::Builder do
  subject(:builder) do
    described_class.new do
      run App
    end
  end

  let(:app) { ->(_env) {} }

  before { stub_const('App', app) }

  specify { expect(builder.to_app).to eq(app) }
end
