class Discount
  attr_reader :items

  def initialize(items: [])
    @items = items
  end

  def discount_rule(code:, qty:)
    rules = discount_rules.select do |rule|
      rule['code'] == code && rule['quantity'] <= qty.to_i
    end

    rules.sort_by.with_index do |h, i|
      [-h['quantity'], i]
    end.first
  end

  private

  def discount_rules
    @discount_rules ||= DiscountRule.select(
      :code, :quantity, :discount
    ).where(code: items).to_a.map(&:serializable_hash)
  end
end
