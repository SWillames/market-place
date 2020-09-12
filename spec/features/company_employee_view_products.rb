require 'rails_helper'

feature 'company employee sees products' do
    scenario 'only from the same company' do
        company_a = Company.create!(name: 'Empresa01', legal_name:'Empresa01 LTDA', cnpj: '98922455000169',
                                    address:'Rua nada, 100', social_media:'linkedin', domain:'@empresa01.com.br')
        company_b = Company.create!(name: 'Empresa02', legal_name:'Empresa02 LTDA', cnpj: '22398473000121',
                                    address:'Rua das aves,1100', social_media:'facebook', domain:'@empresa02.com')
        user = User.create!(name: 'Maria Lima', email:'tatiana@empresa01.com.br', 
                            password: '12345678')
        employee_company_a = CompanyEmployee.create!(full_name:'Sergio Delgado',date_of_birth:'19/05/1990',position:'Recrutador',
                                                            departament:'RH',cpf:'05169113099', company:company_a)
        another_employee_company_a = CompanyEmployee.create!(full_name:'Marina Cardoso',date_of_birth:'19/05/1990',position:'Recrutador',
                                                            departament:'RH',cpf:'45432496070', company:company_a)
        employee_company_b = CompanyEmployee.create!(full_name:'Jessica Santos',date_of_birth:'19/05/1990',position:'Recrutador',
                                                    departament:'RH',cpf:'40520495004', company:company_b)
        

        product_category = ProductCategory.create!(name:'eletronicos',description:'Categoria de produtos eletrônicos')
                            

        ad_A = Ad.create!(title:'Produto A', description:'Descrição do produto A',price:10,
                            status:0 ,product_category:product_category,company_employee: employee_company_a)
        ad_B = Ad.create!(title:'Produto B', description:'Descrição do produto B',price:20,
                            status:0, product_category:product_category,company_employee: another_employee_company_a)
        ad_C = Ad.create!(title:'Produto C', description:'Descrição do produto C',price:30,
                            status:0 ,product_category:product_category,company_employee: employee_company_b)
        

        login_as(user, scope: :user)
        visit root_path

        expect(page).to have_content('Produto A')
        expect(page).to have_content('R$ 10,00')
        expect(page).to have_content('Descrição do produto A')
        expect(page).to have_content('Produto B')
        expect(page).to have_content('R$ 20,00')
        expect(page).to have_content('Descrição do produto B')
        expect(page).not_to have_content('Produto C')
        expect(page).not_to have_content('R$ 30,00')
        expect(page).not_to have_content('Descrição do produto C') 
    end

    scenario ',only the available ones' do
        company = Company.create!(name: 'Empresa01', legal_name:'Empresa01 LTDA', cnpj: '98922455000169',
                                    address:'Rua nada, 100', social_media:'linkedin', domain:'@empresa01.com.br')
        user = User.create!(name: 'Maria Lima', email:'tatiana@empresa01.com.br', 
                            password: '12345678')
        employee_company_a = CompanyEmployee.create!(full_name:'Sergio Delgado',date_of_birth:'19/05/1990',position:'Recrutador',
                                                            departament:'RH',cpf:'05169113099', company:company)
        employee_company_b = CompanyEmployee.create!(full_name:'Jessica Santos',date_of_birth:'19/05/1990',position:'Recrutador',
                                                    departament:'RH',cpf:'40520495004', company:company)
        

        product_category = ProductCategory.create!(name:'eletronicos',description:'Categoria de produtos eletrônicos')
                            

        ad_A = Ad.create!(title:'Produto A', description:'Descrição do produto A',price:10,
                         status:'available' ,product_category:product_category,company_employee: employee_company_a)
        ad_B = Ad.create!(title:'Produto B', description:'Descrição do produto B',price:20,
                          status:'available', product_category:product_category,company_employee: employee_company_a)
        ad_C = Ad.create!(title:'Produto C', description:'Descrição do produto C',price:30,
                          status:'unavailable' ,product_category:product_category,company_employee: employee_company_b)
        ad_D = Ad.create!(title:'Produto D', description:'Descrição do produto D',price:30,
                          status:'unavailable' ,product_category:product_category,company_employee: employee_company_b)
            
        

        login_as(user, scope: :user)
        visit root_path

        expect(page).to have_content('Produto A')
        expect(page).to have_content('R$ 10,00')
        expect(page).to have_content('Descrição do produto A')
        expect(page).to have_content('Produto B')
        expect(page).to have_content('R$ 20,00')
        expect(page).to have_content('Descrição do produto B')
        expect(page).not_to have_content('Produto C')
        expect(page).not_to have_content('R$ 30,00')
        expect(page).not_to have_content('Descrição do produto C') 
        expect(page).not_to have_content('Produto C')
        expect(page).not_to have_content('R$ 30,00')
        expect(page).not_to have_content('Descrição do produto C') 
    end
end