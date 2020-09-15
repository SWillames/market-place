class Ad < ApplicationRecord
  belongs_to :product_category
  belongs_to :company_employee
  has_many_attached :images
  has_many :comments, as: :commentable
  has_many :sales

  enum status: {available: 0, unavailable: 1}

  validates :title, :description, :price, presence: true
  validates :price, numericality: { greater_than: -1 }

  def validate_images
    if images.empty?
      errors.add(:images,"necessária para publicar o anúncio")
    end  
  end  

            
end
