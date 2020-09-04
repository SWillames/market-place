class AddCompanyEmployeeToUser < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :company_employee , default: nil, foreign_key: true
  end
end
