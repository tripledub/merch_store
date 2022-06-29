class PriceCheck
  def total(items: {})
    total = items.inject(0) do |subtotal, (code, qty)|
      subtotal + Product.find_by(code:).pluck(:price) * qty
    end

    total.round(2)
  end
end
