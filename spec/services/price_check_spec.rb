require 'rails_helper'

RSpec.describe 'PriceCheck', type: :service do
  let!(:mug)    { create(:product, code: 'MUG', name: 'Reedsy Mug', price: 6.00) }
  let!(:tshirt) { create(:product, code: 'TSHIRT', name: 'Reedsy T-Shirt', price: 15.00) }
  let!(:hoodie) { create(:product, code: 'HOODIE', name: 'Reedsy Hoodie', price: 20.00) }

  describe '#total' do
    let(:items) { {} }

    subject { PriceCheck.new.total(items:) }

    context 'when there are no items' do
      it { is_expected.to eq(0.00) }
    end
  end
end
