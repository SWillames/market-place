require 'rails_helper'

feature 'Company employee sends doubt about ad' do
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
        
        ad = Ad.create!(title:'Celular Samsung J8', description:'Celular J8 seminovo',price:700,
                        status:1 ,product_category:product_category,company_employee: company_employee2)
        

        login_as user, scope: :user
        visit root_path
        within all('.card', text: 'Celular Samsung J8')[0] do
            click_on 'Comprar'
        end
        
        fill_in placeholder: 'Adicione um comentário' , with: 'O celular está em boas condições?'
        click_on 'Enviar'
    
        expect(page).to have_content('Celular Samsung J8')
        expect(page).to have_content('R$ 700,00')
        expect(page).to have_content('Celular J8 seminovo')
        expect(page).to have_content('Marco Lima')
        expect(page).to have_content('RH')
        expect(page).to have_content('O celular está em boas condições?')
   end

   scenario 'and sees a reply' do
        company = Company.create!(name: 'Empresa01', legal_name:'Empresa01 LTDA', cnpj: '98922455000169',
                                    address:'Rua nada, 100', social_media:'linkedin', domain:'@empresa01.com.br')
        company_employee = CompanyEmployee.create!(full_name:'Marco Silva Lima',date_of_birth:'19/05/1990',position:'Recrutador',
                                                    departament:'RH',cpf:'48227940080',company: company)
        company_employee2 = CompanyEmployee.create!(full_name:'Marlene Delgado Souza',date_of_birth:'19/05/1990',position:'Analista',
                                                    departament:'Marketing',cpf:'06683034095',company: company)
        user = User.create!(name: 'Marco Lima', email:'marco@empresa01.com.br', 
                            password: '12345678', company_employee: company_employee)
        user2 = User.create!(name: 'Marlene Souza', email:'marlene@empresa01.com.br', 
                            password: '12345678', company_employee: company_employee2)



        product_category = ProductCategory.create!(name:'Eletrônicos', description:'Categoria para eletrônicos') 

        ad = Ad.create!(title:'Celular Samsung J8', description:'Celular J8 seminovo',price:700,
                        status:1 ,product_category:product_category,company_employee: company_employee2)

        comment = ad.comments.create!(user:user, parent_id: nil, body:'O produto é novo? ', commentable_type: ad, commentable_id: ad )
        reply = ad.comments.create!(user:user2, parent_id: comment, body:'Sim e possui nota fiscal', commentable_type: ad, commentable_id: ad )

        login_as user, scope: :user
        visit root_path
        within all('.card', text: 'Celular Samsung J8')[0] do
            click_on 'Comprar'
        end

        expect(page).to have_content('Sim e possui nota fiscal')
        expect(page).to have_content('Marlene Souza')
        expect(page).to have_content('Marketing')
    end


end