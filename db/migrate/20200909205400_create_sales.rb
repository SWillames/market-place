class CreateSales < ActiveRecord::Migration[6.0]
  def change
    create_table :sales do |t|
      t.references :buyer, null: false, foreign_key: { to_table: :users }
      t.references :ad, null: false, foreign_key: true
      t.integer :status
      t.decimal :final_price
      t.string :token

      t.timestamps
    end
  end
end
