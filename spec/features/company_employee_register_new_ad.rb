require 'rails_helper'

feature 'Company employee registers new ad' do
    scenario 'successfully' do
        company = Company.create!(name: 'Empresa01', legal_name:'Empresa01 LTDA', cnpj: '98922455000169',
                                 address:'Rua nada, 100', social_media:'linkedin', domain:'@empresa01.com.br')
        company_employee = CompanyEmployee.create!(full_name:'Sergio Delgado',date_of_birth:'19/05/1990',position:'Recrutador',
                                                  departament:'RH',cpf:'05169113099', company:company)
        user = User.create!(name: 'Maria Lima', email:'tatiana@empresa01.com.br', 
                            password: '12345678', company_employee: company_employee)
        
       
        product_category = ProductCategory.create!(name:'Eletrônicos', description:'Categoria para eletrônicos')

    
        login_as(user, scope: :user)
        visit root_path
        click_on 'Anunciar'

        fill_in 'Título do anúncio', with: 'TV 32"'
        fill_in 'Descrição', with: 'Smart TV Samsung 32"'
        fill_in 'Preço', with: '700.00'
        select 'Eletrônicos', from: 'Categoria do produto'
        attach_file 'Imagens do produto', Rails.root.join('spec/support/product_image.jpg')
        click_on 'Cadastrar'
       
        
        expect(current_path).to eq ad_path(Ad.last)
        expect(page).to have_content('TV 32"')
        expect(page).to have_content('Smart TV Samsung 32"')
        expect(page).to have_content('Eletrônicos')
        expect(page).to have_css('img[src*="product_image.jpg"]')
    end

    scenario 'but profile is not complete' do
        company = Company.create!(name: 'Empresa01', legal_name:'Empresa01 LTDA', cnpj: '98922455000169',
                                 address:'Rua nada, 100', social_media:'linkedin', domain:'@empresa01.com.br')
        user = User.create!(name: 'Maria Lima', email:'tatiana@empresa01.com.br', 
                            password: '12345678')
        
       
        product_category = ProductCategory.create!(name:'Eletrônicos', description:'Categoria para eletrônicos')

    
        login_as(user, scope: :user)
        visit root_path
        click_on 'Anunciar'
        
        expect(current_path).to eq new_company_employee_path
        expect(page).to have_content('Complete seu cadastro para anunciar')        
    end


end