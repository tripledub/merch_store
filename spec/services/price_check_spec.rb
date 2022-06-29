require 'rails_helper'

RSpec.describe 'PriceCheck', type: :service do
  let!(:mug)    { create(:product, code: 'MUG', name: 'Reedsy Mug', price: 6.00) }
  let!(:tshirt) { create(:product, code: 'TSHIRT', name: 'Reedsy T-Shirt', price: 15.00) }
  let!(:hoodie) { create(:product, code: 'HOODIE', name: 'Reedsy Hoodie', price: 20.00) }

  describe '#total' do
    let(:items) { {} }

    subject { PriceCheck.new(items:).total }

    context 'when there are no items' do
      it { is_expected.to eq(0.00) }
    end

    context 'when there is one of each item' do
      let(:items) { { 'MUG' => 1, 'TSHIRT' => 1, 'HOODIE' => 1 } }
      it { is_expected.to eq(41.00) }
    end

    context '2 mugs 1 tshirt' do
      let(:items) { { 'MUG' => 2, 'TSHIRT' => 1 } }
      it { is_expected.to eq(27.00) }
    end

    context '3 mugs 1 tshirt' do
      let(:items) { { 'MUG' => 3, 'TSHIRT' => 1 } }
      it { is_expected.to eq(33.00) }
    end

    context '2 mugs 4 tshirts, 1 hoodie' do
      let(:items) { { 'MUG' => 2, 'TSHIRT' => 4, 'HOODIE' => 1 } }
      it { is_expected.to eq(92.00) }
    end
  end
end
