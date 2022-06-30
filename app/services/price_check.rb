class PriceCheck
  attr_reader :items

  def initialize(items: {}, discounts: Discount)
    @items = items
    @discounts = discounts
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
    original_price = products[code]
    rule = rules.discount_rule(code:, qty:)

    if rule
      discount_rate = rule['discount']
      (original_price - (original_price * discount_rate / 100)) * qty.to_i
    else
      original_price * qty.to_i
    end
  end

  def products
    @products ||= Product.where(code: items.keys).pluck(:code, :price).to_h
  end

  def rules
    @rules ||= @discounts.new(items: items.keys)
  end
end
