class CompanyEmployee < ApplicationRecord
  belongs_to :company
  has_many :ads
  has_one :user
end
