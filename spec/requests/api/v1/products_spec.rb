require 'rails_helper'

RSpec.describe 'Api::V1::Products', type: :request do
  describe 'GET /api/v1/products' do
    # Code         | Name                   |  Price
    # -------------------------------------------------
    # MUG          | Reedsy Mug             |   6.00
    # TSHIRT       | Reedsy T-shirt         |  15.00
    # HOODIE       | Reedsy Hoodie          |  20.00

    let!(:mug)    { create(:product, code: 'MUG', name: 'Reedsy Mug', price: 6.00) }
    let!(:tshirt) { create(:product, code: 'TSHIRT', name: 'Reedsy Mug', price: 15.00) }
    let!(:hoodie) { create(:product, code: 'HOODIE', name: 'Reedsy Mug', price: 20.00) }

    before { get '/api/v1/products' }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    describe 'returning all the products and attributes in the store' do
      let(:products) { JSON.parse(response.body) }

      it 'returns all three products' do
        expect(products.size).to eq(3)
      end
    end
  end
end
