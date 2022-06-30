require 'rails_helper'

RSpec.describe 'Discount', type: :service do
  let!(:tshirt) do
    create(:product, code: 'TSHIRT', name: 'Reedsy T-Shirt', price: 15.00).tap do |tshirt|
      create(:discount_rule, product: tshirt, code: tshirt.code, quantity: 3, discount: 30)
    end
  end

  let!(:mug) do
    create(:product, code: 'MUG', name: 'Reedsy Mug', price: 6.00).tap do |mug|
      create(:discount_rule, product: mug, code: mug.code, quantity: 10, discount: 2)
      create(:discount_rule, product: mug, code: mug.code, quantity: 45, discount: 8)
      create(:discount_rule, product: mug, code: mug.code, quantity: 200, discount: 30)
    end
  end

  let!(:hoodie) { create(:product, code: 'HOODIE', name: 'Reedsy Hoodie', price: 20.00) }

  let(:items) { [] }

  describe '#discount rule' do
    subject { Discount.new(items:).discount_rule(code:, qty:) }

    context 'with no matching rule' do
      let(:code) { 'FOO' }
      let(:qty) { 0 }
      it { is_expected.to be_nil }
    end

    context 'matching rules' do
      let(:items) { %w[HOODIE MUG TSHIRT] }
      let(:code) { 'TSHIRT' }
      let(:qty) { 3 }

      scenario '3 or more t-shirts' do
        rule = Discount.new(items:).discount_rule(code: 'TSHIRT', qty: 3)
        expect(rule['discount']).to eq(30)
      end

      scenario '10 mugs' do
        rule = Discount.new(items:).discount_rule(code: 'MUG', qty: 10)
        expect(rule['discount']).to eq(2)
      end

      scenario '11mugs' do
        rule = Discount.new(items:).discount_rule(code: 'MUG', qty: 11)
        expect(rule['discount']).to eq(2)
      end

      scenario '45 mugs' do
        rule = Discount.new(items:).discount_rule(code: 'MUG', qty: 45)
        expect(rule['discount']).to eq(8)
      end

      scenario '201 mugs' do
        rule = Discount.new(items:).discount_rule(code: 'MUG', qty: 201)
        expect(rule['discount']).to eq(30)
      end
    end
  end
end
