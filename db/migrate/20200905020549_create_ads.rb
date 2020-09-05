class CreateAds < ActiveRecord::Migration[6.0]
  def change
    create_table :ads do |t|
      t.string :title
      t.string :description
      t.decimal :price
      t.integer :status
      t.references :product_category, null: false, foreign_key: true
      t.references :company_employee, null: false, foreign_key: true

      t.timestamps
    end
  end
end
