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

  def discount_rule(code:, qty:)
    rules = discount_rules.select do |rule|
      rule['code'] == code && rule['quantity'] <= qty.to_i
    end

    rules.sort_by.with_index do |h, i|
      [-h['quantity'], i]
    end.first
  end

  def discount_rules
    @discount_rules ||= DiscountRule.select(
      :code, :quantity, :discount
    ).where(code: items.keys).to_a.map(&:serializable_hash)
  end

  def price_with_discount(code:, qty:)
    original_price = products[code]
    rule = discount_rule(code:, qty:)

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
end
