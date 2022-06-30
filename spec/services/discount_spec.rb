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
      create(:discount_rule, product: mug, code: mug.code, quantity: 40, discount: 8)
      create(:discount_rule, product: mug, code: mug.code, quantity: 150, discount: 30)
    end
  end

  let!(:hoodie) { create(:product, code: 'HOODIE', name: 'Reedsy Hoodie', price: 20.00) }

  let(:items) { [] }

  describe '#discount rule' do
    subject { Discount.new(items:).discounted_price(code:, price:, qty:) }

    context 'with no matching rule, price remains the same' do
      let(:code) { hoodie.code }
      let(:qty) { 1 }
      let(:price) { hoodie.price }
      it { is_expected.to eq(hoodie.price) }
    end

    context 'matching rules' do
      let!(:items) { %w[HOODIE MUG TSHIRT] }

      context '10 or more MUG gives a 2% discount' do
        let(:price) { 6 }
        let(:qty) { 10 }
        let(:code) { 'MUG' }
        it { is_expected.to eq(5.88) }
      end

      context '40 or more MUG gives a 8% discount' do
        let(:price) { 6 }
        let(:qty) { 41 }
        let(:code) { 'MUG' }
        it { is_expected.to eq(5.52) }
      end

      context '150 or more MUG gives a 30% discount' do
        let(:price) { 6 }
        let(:qty) { 1000 }
        let(:code) { 'MUG' }
        it { is_expected.to eq(4.2) }
      end

      context '3 or more TSHIRT gives 30% discount' do
        let(:price) { 15 }
        let(:qty) { 4 }
        let(:code) { 'TSHIRT' }
        it { is_expected.to eq(10.5) }
      end

      context 'less than 3 TSHIRT gives 0% discount' do
        let(:price) { 15 }
        let(:qty) { 2 }
        let(:code) { 'TSHIRT' }
        it { is_expected.to eq(tshirt.price) }
      end
    end
  end
end
