class CreateCompanyEmployees < ActiveRecord::Migration[6.0]
  def change
    create_table :company_employees do |t|
      t.string :full_name
      t.date :date_of_birth
      t.string :position
      t.string :departament
      t.string :cpf
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
