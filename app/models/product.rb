class Product < ApplicationRecord
  has_many  :discount_rules, dependent: :destroy
  validates :price, presence: true, numericality: { only_float: true }
end
