require 'spec_helper'

RSpec.describe Jumpup do
  include_examples 'capture stdout'

  before do
    Object.send(:remove_const, :INTEGRATION_TASKS) if Object.const_defined?(:INTEGRATION_TASKS)
  end

  describe 'INTEGRATION_TASKS is not defined'  do
    it { expect { rake_integrate }.to raise_exception(SystemExit) }
    it 'show a help message about the missing constant' do
      begin
        rake_integrate
      rescue SystemExit
        expect(@output.string).to include('You should define INTEGRATION_TASKS constant.')
      end
    end
  end

  describe 'INTEGRATION_TASKS is defined'  do
    before { load_tasks }
    before { rake_integrate }

    it { expect(@output.string).to include('One') }
    it { expect(@output.string).to include('Two') }
    it { expect(@output.string).to include('Three') }
  end
end
