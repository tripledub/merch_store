require 'rails_helper'

RSpec.describe 'Api::V1::PriceCheck', type: :request do
  let!(:mug)    { create(:product, code: 'MUG', name: 'Reedsy Mug', price: 6.00) }
  let!(:tshirt) { create(:product, code: 'TSHIRT', name: 'Reedsy T-Shirt', price: 15.00) }
  let!(:hoodie) { create(:product, code: 'HOODIE', name: 'Reedsy Hoodie', price: 20.00) }
  let(:params)  { {} }
  let(:items) { {} }

  describe 'POST /api/v1/price_check' do
    before { post '/api/v1/price_check', params: }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    let(:params) { { query: { items: } } }

    context '1 of each item' do
      let(:items) { { 'MUG' => 1, 'TSHIRT' => 1, 'HOODIE' => 1 } }

      it 'returns the correct price' do
        expect(json).to eq(41.0)
      end
    end

    context '2 mugs 4 tshirts, 1 hoodie' do
      let(:items) { { 'MUG' => 2, 'TSHIRT' => 4, 'HOODIE' => 1 } }

      it 'returns the correct price' do
        expect(json).to eq(92.0)
      end
    end
  end
end
