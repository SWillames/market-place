class Company < ApplicationRecord
 
    validates :name, :legal_name, :cnpj, :address, :social_media, 
               :domain, presence: true
    validates :cnpj, uniqueness: true
    validate :validates_cnpj

    def validates_cnpj
        if !cnpj.blank? and !CNPJ.valid?(cnpj)
            errors.add(:cnpj, "inválido") 
        end
    end

end
 