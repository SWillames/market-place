require 'rails_helper'


feature 'Company employee searches ads' do
    scenario 'and finds by name' do
        company = Company.create!(name: 'Empresa01', legal_name:'Empresa01 LTDA', cnpj: '98922455000169',
                                  address:'Rua nada, 100', social_media:'linkedin', domain:'@empresa01.com.br')
        company_employee = CompanyEmployee.create!(full_name:'Maria Silva Lima',date_of_birth:'19/05/1990',position:'Recrutador',
                                                   departament:'RH',cpf:'05169113099', company:company)
        company_employee2 = CompanyEmployee.create!(full_name:'Sergio Delgado',date_of_birth:'19/05/1990',position:'Recrutador',
                                                    departament:'RH',cpf:'70540069094', company:company)
        user = User.create!(name: 'Maria Lima', email:'tatiana@empresa01.com.br', 
                            password: '12345678', company_employee: company_employee)


        product_category = ProductCategory.create!(name:'Eletrônicos', description:'Categoria para eletrônicos') 
        
        ad_A = Ad.create!(title:'Celular', description:'Descrição',price:700,
                          status:1 ,product_category:product_category,company_employee: company_employee2)
        ad_B = Ad.create!(title:'Celular motorola', description:'Descrição',price:500,
                          status:1, product_category:product_category,company_employee: company_employee2)
        ad_C = Ad.create!(title:'Geladeira', description:'Descrição',price:865,
                          status:1 ,product_category:product_category,company_employee: company_employee2)

        login_as user, scope: :user
        visit root_path
        fill_in 'Buscar produto', with: 'celular'
        click_on 'Buscar'

        expect(page).to have_content('Celular')
        expect(page).to have_content('R$ 700,00')
        expect(page).to have_content('Celular motorola')
        expect(page).to have_content('R$ 500,00')
        expect(page).not_to have_content('Geladeira')
        expect(page).not_to have_content('R$ 865,00')
    end

    scenario 'and finds by description' do
        company = Company.create!(name: 'Empresa01', legal_name:'Empresa01 LTDA', cnpj: '98922455000169',
                                  address:'Rua nada, 100', social_media:'linkedin', domain:'@empresa01.com.br')
        company_employee = CompanyEmployee.create!(full_name:'Maria Silva Lima',date_of_birth:'19/05/1990',position:'Recrutador',
                                                   departament:'RH',cpf:'05169113099', company:company)
        company_employee2 = CompanyEmployee.create!(full_name:'Sergio Delgado',date_of_birth:'19/05/1990',position:'Recrutador',
                                                    departament:'RH',cpf:'70540069094', company:company)
        user = User.create!(name: 'Maria Lima', email:'tatiana@empresa01.com.br', 
                            password: '12345678', company_employee: company_employee)


        product_category = ProductCategory.create!(name:'Eletrônicos', description:'Categoria para eletrônicos') 
        
        ad_A = Ad.create!(title:'Produto A', description:'Celular 6" samsung',price:700,
                          status:1 ,product_category:product_category,company_employee: company_employee2)
        ad_B = Ad.create!(title:'Produto B', description:'Celular 6" motorola',price:500,
                          status:1, product_category:product_category,company_employee: company_employee2)
        ad_C = Ad.create!(title:'Produto C', description:'Geladeira brastemp',price:865,
                          status:1 ,product_category:product_category,company_employee: company_employee2)

        login_as user, scope: :user
        visit root_path
        fill_in 'Buscar produto', with: 'Celular 6"'
        click_on 'Buscar'

        expect(page).to have_content('Produto A')
        expect(page).to have_content('R$ 700,00')
        expect(page).to have_content('Produto B')
        expect(page).to have_content('R$ 500,00')
        expect(page).not_to have_content('Produto C')
        expect(page).not_to have_content('R$ 865,00')
    end

    scenario 'and filters by category' do
        company = Company.create!(name: 'Empresa01', legal_name:'Empresa01 LTDA', cnpj: '98922455000169',
                                  address:'Rua nada, 100', social_media:'linkedin', domain:'@empresa01.com.br')
        company_employee = CompanyEmployee.create!(full_name:'Maria Silva Lima',date_of_birth:'19/05/1990',position:'Recrutador',
                                                   departament:'RH',cpf:'05169113099', company:company)
        company_employee2 = CompanyEmployee.create!(full_name:'Sergio Delgado',date_of_birth:'19/05/1990',position:'Recrutador',
                                                    departament:'RH',cpf:'70540069094', company:company)
        user = User.create!(name: 'Maria Lima', email:'tatiana@empresa01.com.br', 
                            password: '12345678', company_employee: company_employee)


        product_category_eletronics = ProductCategory.create!(name:'Eletrônicos', description:'Categoria para eletrônicos') 
        product_category_furniture = ProductCategory.create!(name:'Móveis', description:'Categoria para Móveis') 

        
        ad_A = Ad.create!(title:'celular', description:'Celular 6" samsung',price:700,
                          status:1 ,product_category:product_category_eletronics,company_employee: company_employee2)
        ad_B = Ad.create!(title:'Sofá', description:'Sofá preto estofado',price:500,
                          status:1, product_category:product_category_furniture,company_employee: company_employee2)
        ad_C = Ad.create!(title:'Mesa', description:'Mesa de madeira',price:865,
                          status:1 ,product_category:product_category_furniture,company_employee: company_employee2)

        login_as user, scope: :user
        visit root_path
        click_on 'Móveis'

        expect(page).to have_content('Sofá')
        expect(page).to have_content('R$ 500,00')
        expect(page).to have_content('Mesa')
        expect(page).to have_content('R$ 865,00')
        expect(page).not_to have_content('celular')
        expect(page).not_to have_content('R$ 700,00')
    end
end