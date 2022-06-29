require 'rails_helper'

RSpec.describe 'Api::V1::Products', type: :request do
  # Code         | Name                   |  Price
  # -------------------------------------------------
  # MUG          | Reedsy Mug             |   6.00
  # TSHIRT       | Reedsy T-shirt         |  15.00
  # HOODIE       | Reedsy Hoodie          |  20.00

  let!(:mug)    { create(:product, code: 'MUG', name: 'Reedsy Mug', price: 6.00) }
  let!(:tshirt) { create(:product, code: 'TSHIRT', name: 'Reedsy T-Shirt', price: 15.00) }
  let!(:hoodie) { create(:product, code: 'HOODIE', name: 'Reedsy Hoodie', price: 20.00) }

  describe 'GET /api/v1/products' do
    before { get '/api/v1/products' }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    describe 'returning all the products and attributes in the store' do
      it 'returns all three products' do
        expect(json.size).to eq(3)
      end

      it 'returns the correct attributes' do
        expect(json[0]['code']).to eq(mug.code)
        expect(json[1]['name']).to eq(tshirt.name)
        expect(json[2]['price']).to eq(hoodie.price)
      end
    end
  end

  describe 'PUT /api/v1/products/:id' do
    let(:price) { 5.00 }
    let(:payload) { { price: } }
    let(:id) { mug.id }

    before do
      put "/api/v1/products/#{id}", params: {
        product: payload
      }
    end

    scenario 'vaild price attribute' do
      expect(response).to have_http_status(:success)
      expect(mug.reload.price).to eq(price)
    end

    context 'when a product does not exist' do
      let(:id) { Product.last.id + 1 }
      scenario 'product id is out of range' do
        expect(response).to have_http_status(:not_found)
        expect(json['message']).to eq("Couldn't find Product with 'id'=#{id}")
      end
    end

    context 'when price is not of type float' do
      let(:price) { 'foo' }
      scenario 'price is a string' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json['message']).to eq('Validation failed: Price is not a number')
      end
    end

    context 'returns a useful status and message when required params are missing' do
      let(:payload) { nil }

      scenario 'product is missing' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json['message']).to eq('param is missing or the value is empty: product')
      end
    end
  end
end
