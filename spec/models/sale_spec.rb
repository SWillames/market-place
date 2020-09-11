require 'rails_helper'

RSpec.describe Sale, type: :model do
    context 'token' do
        it 'generate on create' do
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

            ad = Ad.create!(title:'Celular Samsung J8', description:'Celular J8 seminovo, nenhum arranhão',price:700,
                status:1 ,product_category:product_category,company_employee: company_employee2)

            sale = Sale.create!(buyer: user, ad: ad)

            sale.save
            
            expect(sale.token).to be_present
            expect(sale.token.size).to eq(6)
            expect(sale.token).to match(/^[A-Z0-9]+$/)
        end 
    end    
end
