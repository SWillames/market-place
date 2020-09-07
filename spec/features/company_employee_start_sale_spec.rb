require 'rails_helper'

feature 'Company employee start sale' do
    scenario 'successfully' do
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


        login_as user, scope: :user
        visit root_path
        click_on 'Celular Samsung J8'
        click_on 'Comprar'
        
        expect(page).to have_content('Celular Samsung J8')
        expect(page).to have_content('R$ 700,00')
        expect(page).to have_content('Celular J8 seminovo, nenhum arranhão')
        expect(page).to have_content('Marlene Souza - RH')
        expect(page).to have_link('Concluir venda')
        expect(page).to have_link('Cancelar venda')
   end

   scenario 'and send a private message' do
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


        login_as user, scope: :user
        visit root_path
        click_on 'Celular Samsung J8'
        click_on 'Comprar'

        fill_in placeholder: 'Envie uma mensagem ao vendedor...', with: 'Olá, gostaria de comprar o produto'
        click_on 'Enviar'

        expect(page).to have_content('Celular Samsung J8')
        expect(page).to have_content('R$ 700,00')
        expect(page).to have_content('Celular J8 seminovo')
        expect(page).to have_content('Marco Lima')
        expect(page).to have_content('RH')
        expect(page).to have_content('Olá, gostaria de comprar o produto')
 end

 
end