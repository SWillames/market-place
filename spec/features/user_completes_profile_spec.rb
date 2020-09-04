require 'rails_helper'

feature 'User completes profile' do
    scenario 'not logged in' do
        visit new_company_employee_path
        expect(current_path).to eq new_user_session_path 
    end

    scenario 'successfully' do
        company = Company.create!(name: 'Empresa01', legal_name:'Empresa01 LTDA', cnpj: '98922455000169',
                                  address:'Rua nada, 100', social_media:'linkedin', domain:'@empresa01.com.br')
        user = User.create!(name: 'Maria Lima', email:'tatiana@empresa01.com.br', 
                            password: '12345678')

        login_as(user, scope: :user)
        visit root_path
        click_on 'Meu Perfil'
        
        fill_in 'Nome completo', with: 'Maria Silva Lima'
        fill_in 'Data de nascimento', with: '17/08/1990'
        fill_in 'Cargo', with: 'Recrutadora'
        fill_in 'Setor', with: 'RH'
        fill_in 'CPF', with: '86368474009'
        click_on 'Cadastrar'

        expect(page).to have_content('Perfil salvo com sucesso!')
        expect(page).to have_content('Maria Lima')
        expect(page).to have_content('Maria Silva Lima')
        expect(page).to have_content('17/08/1990')
        expect(page).to have_content('Empresa01')
        expect(page).to have_content('Recrutadora')
        expect(page).to have_content('RH')
        expect(page).to have_content('86368474009')
        
    end
end

