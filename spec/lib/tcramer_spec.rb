# frozen_string_literal: true

RSpec.describe Tcramer do
  describe 'isms' do
    subject { described_class.const_get('ISMS') }

    it { is_expected.to be_a Array }
  end

  describe 'face' do
    subject { described_class.const_get('FACE') }

    it { is_expected.to be_a String }
  end

  describe '.manage' do
    before { allow(Kernel).to receive(:rand).and_return(rand_integer) }

    context 'when zalgoized' do
      let(:rand_integer) { 0 }

      it 'uses the Zalgo library to render one ism' do
        expect(Zalgo).to receive(:he_comes).once
        described_class.manage
      end
    end

    context 'when not zalgoized' do
      subject { described_class.manage }

      let(:rand_integer) { 1 }

      it { is_expected.to be_in described_class::ISMS }
    end
  end

  describe '.motivate' do
    subject { described_class.motivate }

    it { is_expected.to eq described_class::FACE }
  end
end
