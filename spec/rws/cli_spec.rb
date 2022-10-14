# frozen_string_literal: true

require 'spec_helper'

require 'rws/cli'

RSpec.describe RWS::CLI do
  subject(:run_cli) { described_class.new(argv).run }

  shared_examples 'missing option argument' do |option|
    context 'without argument' do
      let(:argv) { [option] }

      it { expect { run_cli }.to raise_error OptionParser::MissingArgument }
    end
  end

  before do
    server_instance = instance_double(RWS::Server)
    allow(server_instance).to receive(:run)
    allow(RWS::Server).to receive(:new).and_return(server_instance)
  end

  describe '-p, --port PORT' do
    let(:argv) { ['-p', '8080'] }

    it 'run server with port param' do
      run_cli

      expect(RWS::Server).to have_received(:new).with(hash_including(port: 8080))
    end

    include_examples 'missing option argument', '-p'
  end

  describe '-h, --host HOST' do
    let(:argv) { ['--host', '0.0.0.0'] }

    it 'run server with host param' do
      run_cli

      expect(RWS::Server).to have_received(:new).with(hash_including(host: '0.0.0.0'))
    end

    include_examples 'missing option argument', '--host'
  end

  describe '--help' do
    let(:argv) { ['--help'] }

    it 'prints help info and exit' do
      expect { run_cli }.to output(/Print help info/).to_stdout.and raise_error(SystemExit)
    end
  end

  describe '--version' do
    let(:argv) { ['--version'] }

    it 'prints current version and exit' do
      expect { run_cli }.to output(/#{RWS::VERSION}/).to_stdout.and raise_error(SystemExit)
    end
  end
end
