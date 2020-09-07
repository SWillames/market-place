class Sale < ApplicationRecord
  belongs_to :ad
  belongs_to :buyer, class_name: "CompanyEmployee"
  has_many :comments, as: :commentable

  before_create :generate_token

  enum status: {started: 0, waiting_seller: 1, sold: 2, canceled: 3}

  private  
  def generate_token
    self.token = SecureRandom.alphanumeric(6).upcase
  end 
end
