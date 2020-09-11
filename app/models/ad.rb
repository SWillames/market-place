class Ad < ApplicationRecord
  belongs_to :product_category
  belongs_to :company_employee
  has_many_attached :images
  has_many :comments, as: :commentable
  has_many :sales

  enum status: {available: 0, unavailable: 1}

end
