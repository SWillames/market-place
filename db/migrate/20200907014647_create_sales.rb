class CreateSales < ActiveRecord::Migration[6.0]
  def change
    create_table :sales do |t|
      t.integer :buyer_id
      t.references :ad, null: false, foreign_key: true
      t.integer :status
      t.string :token
      t.decimal :final_price

      t.timestamps
    end
  end
end
