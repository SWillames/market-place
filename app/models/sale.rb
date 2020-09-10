class Sale < ApplicationRecord
  belongs_to :buyer , class_name: "User", foreign_key: :buyer_id
  belongs_to :ad
  has_many :comments, as: :commentable

  before_create :generate_token

  enum status: {waiting_seller: 0, sold: 1, canceled: 2}

  private  
  def generate_token
    self.token = SecureRandom.alphanumeric(6).upcase
  end 

end
