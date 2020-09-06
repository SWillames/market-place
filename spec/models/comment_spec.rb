require 'rails_helper'

RSpec.describe User, type: :model do
  describe ".comments" do 
    it ' should return just child comments' do
        company = Company.create!(name: 'Empresa01', legal_name:'Empresa01 LTDA', cnpj: '98922455000169',
                                    address:'Rua nada, 100', social_media:'linkedin', domain:'@empresa01.com.br')
        company_employee = CompanyEmployee.create!(full_name:'Marco Silva Lima',date_of_birth:'19/05/1990',position:'Recrutador',
                                                    departament:'RH',cpf:'48227940080',company: company)
        company_employee2 = CompanyEmployee.create!(full_name:'Marlene Delgado Souza',date_of_birth:'19/05/1990',position:'Recrutador',
                                                    departament:'RH',cpf:'06683034095',company: company)
        user = User.create!(name: 'Marco Lima', email:'marco@empresa01.com.br', 
                            password: '12345678', company_employee: company_employee)
        user2 = User.create!(name: 'Marlene Souza', email:'marlene@empresa01.com.br', 
                            password: '12345678', company_employee: company_employee2)

        product_category = ProductCategory.create!(name:'Eletrônicos', description:'Categoria para eletrônicos') 
        
        ad = Ad.create!(title:'Celular Samsung J8', description:'Celular J8 seminovo',price:700,
                        status:1 ,product_category:product_category,company_employee: company_employee2)

        comment1A = ad.comments.create!(user:user, parent_id: nil, body:'Comentário 1A', commentable_type: ad, commentable_id: ad )
        comment1B = ad.comments.create!(user:user2, parent_id: comment1A.id, body:'Comentário 1B', commentable_type: ad, commentable_id: ad )
        comment1C = ad.comments.create!(user:user, parent_id: comment1A.id, body:'Comentário 1C', commentable_type: ad, commentable_id: ad )
        comment2A = ad.comments.create!(user:user, parent_id: nil, body:'Comentário 2A', commentable_type: ad, commentable_id: ad )

        comments = comment1A.comments

        expect(comments).to include(comment1B)
        expect(comments).to include(comment1C)
        expect(comments).not_to include(comment2A)
    end
  end  
end
