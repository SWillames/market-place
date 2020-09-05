require 'rails_helper'

RSpec.describe User, type: :model do
  describe ".domain" do 
    it ' should return user email domain' do
      user = User.create!(name: 'Maria Lima', email:'tatiana@empresa01.com.br', 
                          password: '12345678')
      result = user.domain()

      expect(result).to eq '@empresa01.com.br'
    end
  end  
end
