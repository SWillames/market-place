require 'rails_helper'

feature 'User sign in' do
    scenario 'from home page' do
        visit root_path
        expect(current_path).to eq user_session_path
        expect(page).to have_button('Entrar')
    end

    scenario 'successfully' do
        company = Company.create!(name: 'Empresa01', legal_name:'Empresa01 LTDA', cnpj: '98922455000169',
                                    address:'Rua nada, 100', social_media:'linkedin', domain:'@empresa01.com.br')
        company_employee = CompanyEmployee.create!(full_name:'Sergio Souza Delgado',date_of_birth:'19/05/1990',position:'Recrutador',
                                                            departament:'RH',cpf:'05169113099', company:company)
                            
        User.create!(name: 'Sérgio Delgado', email:'sergio@empresa01.com.br', 
                     password: '12345678', company_employee:company_employee )

        visit root_path
        click_on 'Entrar'
        fill_in 'Email', with: "sergio@empresa01.com.br"
        fill_in 'Senha', with: "12345678"
        click_on 'Entrar'

        expect(page).to have_content 'Sérgio Delgado'
        expect(page).to have_content 'Login efetuado com sucesso'
        expect(page).to have_link 'Sair'
        expect(page).not_to have_button 'Entrar'
        
    end

    scenario 'and sign out' do
        company = Company.create!(name: 'Empresa01', legal_name:'Empresa01 LTDA', cnpj: '98922455000169',
                                  address:'Rua nada, 100', social_media:'linkedin', domain:'@empresa01.com.br')
        company_employee = CompanyEmployee.create!(full_name:'Sergio Souza Delgado',date_of_birth:'19/05/1990',position:'Recrutador',
                                departament:'RH',cpf:'05169113099', company:company)

        user = User.create!(name: 'Sérgio Delgado', email:'sergio@empresa01.com.br', 
                     password: '12345678', company_employee:company_employee )

        login_as(user, scope: :user)
        visit root_path
        click_on 'Sair'

        expect(current_path).to eq user_session_path
        expect(page).to have_content 'Para continuar, efetue login ou registre-se.'
        expect(page).to have_button 'Entrar'
        expect(page).not_to have_link 'Sair'
                
    end
end

