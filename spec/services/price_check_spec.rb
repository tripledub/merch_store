require 'rails_helper'

RSpec.describe 'PriceCheck', type: :service do
  describe '#total' do
    subject { PriceCheck.new.total }

    context 'when there are no items' do
      it { is_expected.to eq(0.00) }
    end
  end
end
