class PriceCheck
  attr_reader :items

  def initialize(items: {})
    @items = items
  end

  def self.total(items:)
    new(items:).total
  end

  def total
    total = items.inject(0) do |subtotal, (code, qty)|
      subtotal + price_with_discount(code:, qty:)
    end

    total.round(2)
  end

  private

  def price_with_discount(code:, qty:)
    discount = DiscountRule.where(code:, quantity: ..qty).order('quantity DESC').first
    original_price = products[code]

    # debugger

    if discount
      discount_rate = discount.discount
      (original_price - (original_price * discount_rate / 100)) * qty.to_i
    else
      original_price * qty.to_i
    end
  end

  def products
    @products ||= Product.where(code: items.keys).pluck(:code, :price).to_h
  end
end
