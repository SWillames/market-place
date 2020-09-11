require 'rails_helper'

feature 'Company employee sell a product' do
    scenario 'and sees in his history' do
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
        sale = Sale.create!(buyer: user, ad: ad, status:'in_progress',final_price: nil )
        history_buyer = History.create!(user:user,sale:sale, history_type:'purchase',)
        history_seller = History.create!(user:user2,sale:sale, history_type:'sale')
        

        login_as user2, scope: :user
        visit root_path
        click_on 'Meu histórico'
        
        expect(page).to have_content('Meu histórico')
        expect(page).to have_content(sale.token)
        expect(page).to have_content('Venda')
        expect(page).to have_content('Celular Samsung J8')
        expect(page).to have_content('R$ 700,00')
        expect(page).to have_content('Em andamento')     
   end

    scenario 'and confirms sale' do
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
        sale = Sale.create!(buyer: user, ad: ad, status:'in_progress',final_price: nil)
        history_buyer = History.create!(user:user,sale:sale, history_type:'purchase')
        history_seller = History.create!(user:user2,sale:sale, history_type:'sale')
        

        login_as user2, scope: :user
        visit root_path
        click_on 'Meu histórico'
        click_on sale.token
        fill_in 'Preço final', with: '650'
        click_on 'Concluir venda'
        

        expect(page).to have_content('Celular Samsung J8')
        expect(page).to have_content('R$ 700,00')
        expect(page).to have_content('Celular J8 seminovo, nenhum arranhão')
        expect(page).to have_content('Marlene Souza - RH')
        expect(page).to have_content('Parabéns! Este produto foi vendido')
    end

    scenario 'and cancels sale' do
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
        sale = Sale.create!(buyer: user, ad: ad, status:'in_progress',final_price: nil)
        history_buyer = History.create!(user:user,sale:sale, history_type:'purchase')
        history_seller = History.create!(user:user2,sale:sale, history_type:'sale')
        

        login_as user2, scope: :user
        visit root_path
        click_on 'Meu histórico'
        click_on sale.token
        click_on 'Cancelar venda'
        
        expect(page).to have_content('Celular Samsung J8')
        expect(page).to have_content('R$ 700,00')
        expect(page).to have_content('Celular J8 seminovo, nenhum arranhão')
        expect(page).to have_content('Marlene Souza - RH')
        expect(page).to have_content('Você cancelou esta venda X_X')
    end


end