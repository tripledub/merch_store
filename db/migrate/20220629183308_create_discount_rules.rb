class CreateDiscountRules < ActiveRecord::Migration[7.0]
  def change
    create_table :discount_rules do |t|
      t.string  :code
      t.integer :quantity
      t.integer :discount
      t.belongs_to :product, null: false, foreign_key: true

      t.timestamps
    end

    add_index :discount_rules, :code
  end
end
