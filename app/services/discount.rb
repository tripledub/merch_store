class Discount
  attr_reader :items

  def initialize(items: [])
    @items = items
  end

  def discounted_price(code:, price:, qty:)
    rule = discount_rule(code:, qty:)

    return price unless rule

    (price - (price * rule['discount'] / 100.to_f))
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
    ).where(code: items).to_a.map(&:serializable_hash)
  end
end
