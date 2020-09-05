class Ad < ApplicationRecord
  belongs_to :product_category
  belongs_to :company_employee
end
