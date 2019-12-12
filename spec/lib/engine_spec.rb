# frozen_string_literal: true

RSpec.describe Tcramer::Engine do
  describe 'inheritance' do
    subject { described_class.ancestors }

    it { is_expected.to include Rails::Engine }
  end
end
