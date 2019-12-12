# frozen_string_literal: true

RSpec.describe Tcramer do
  describe 'version constant' do
    subject { described_class.const_get('VERSION') }

    it { is_expected.to be_a String }
  end
end
