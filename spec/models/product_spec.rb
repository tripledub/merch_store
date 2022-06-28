require 'rails_helper'

RSpec.describe Product, type: :model do
  let!(:product_one) { create(:product, code: 'tshirt', name: 'shirt one') }

  describe 'database constraints' do
    it 'product code should be uniq' do
      expect do
        Product.create(code: 'tshirt', name: 'shirt with same code')
      end.to raise_error(ActiveRecord::RecordNotUnique)
    end
  end
end
