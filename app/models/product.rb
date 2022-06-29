class Product < ApplicationRecord
  validates :price, presence: true, numericality: { only_float: true }
end
