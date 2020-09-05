class User < ApplicationRecord
   belongs_to :company_employee, optional: true
   
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  def domain
    "#{string = email.slice!(/@.*/)}"
  end

end