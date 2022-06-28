require 'rails_helper'

RSpec.describe 'Api::V1::Products', type: :request do
  describe 'GET /index' do
    # Code         | Name                   |  Price
    # -------------------------------------------------
    # MUG          | Reedsy Mug             |   6.00
    # TSHIRT       | Reedsy T-shirt         |  15.00
    # HOODIE       | Reedsy Hoodie          |  20.00

    it 'returns http success' do
      get '/api/v1/products'
      expect(response).to have_http_status(:success)
    end
  end
end
