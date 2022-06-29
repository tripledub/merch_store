require 'rails_helper'

RSpec.describe Product, type: :model do
  let!(:product_one) { create(:product, code: 'tshirt', name: 'shirt one', price: 1.20) }

  describe 'database constraints' do
    it 'product code should be uniq' do
      expect do
        Product.create(code: 'tshirt', name: 'shirt with same code', price: 1.20)
      end.to raise_error(ActiveRecord::RecordNotUnique)
    end
  end
end
