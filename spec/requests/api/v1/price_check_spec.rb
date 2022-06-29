require 'rails_helper'

RSpec.describe 'Api::V1::PriceCheck', type: :request do
  # Code         | Name                   |  Price
  # -------------------------------------------------
  # MUG          | Reedsy Mug             |   6.00
  # TSHIRT       | Reedsy T-shirt         |  15.00
  # HOODIE       | Reedsy Hoodie          |  20.00

  let!(:mug)    { create(:product, code: 'MUG', name: 'Reedsy Mug', price: 6.00) }
  let!(:tshirt) { create(:product, code: 'TSHIRT', name: 'Reedsy T-Shirt', price: 15.00) }
  let!(:hoodie) { create(:product, code: 'HOODIE', name: 'Reedsy Hoodie', price: 20.00) }

  describe 'POST /api/v1/price_check' do
    before { post '/api/v1/price_check', params: {} }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end
end
