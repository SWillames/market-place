class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :legal_name
      t.string :cnpj
      t.string :address
      t.string :social_media
      t.string :domain

      t.timestamps
    end
  end
end
