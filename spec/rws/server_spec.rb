# frozen_string_literal: true

require 'spec_helper'

require 'rws/server'

RSpec.describe RWS::Server do
  subject(:run_server) { described_class.new(**params).run }

  let(:params) { { host: '0.0.0.0', port: 8080 } }

  before { allow(described_class).to receive(:new).and_call_original }

  xit { expect { run_server }.not_to raise_error }
end
