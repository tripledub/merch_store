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
    items.inject(0) do |subtotal, (code, qty)|
      subtotal + price_lookup(code:, qty:)
    end.round(2)
  end

  private

  def discounter
    @discounter ||= @discounts.new(items: items.keys)
  end

  def price_lookup(code:, qty:)
    price = products[code]
    discounter.discounted_price(code:, price:, qty:).to_f * qty.to_i
  end

  def products
    @products ||= Product.where(code: items.keys).pluck(:code, :price).to_h
  end
end
