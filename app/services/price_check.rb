class PriceCheck
  attr_reader :items

  def initialize(items: {})
    @items = items
  end

  def total
    total = items.inject(0) do |subtotal, (code, qty)|
      subtotal + products[code] * qty.to_i
    end

    total.round(2)
  end

  private

  def products
    @products ||= Product.where(code: items.keys).pluck(:code, :price).to_h
  end
end
