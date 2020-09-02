require 'rails_helper'

feature 'employee completes profile' do
    scenario 'successfully' do
        company = Company.create!(name:'Empresa 01', legal_name:'Empresa 01', 
        cnpj:'22301627000115', address:'Rua tal', social_media:'facebook', domain:'@empresa01.com' )
        
        visit root_path
        click_on 'Meu perfil'

        fill_in 'Nome completo', with: 'Maria Silva Lima'
        fill_in 'Nome social', with: 'Maria Lima'
        fill_in 'Data de nascimento', with: '17/08/1990'
        fill_in 'Cargo', with: 'Recrutadora'
        fill_in 'Setor', with: 'RH'
        fill_in 'CPF', with: '86368474009'
        click_on 'Cadastrar'

        
        expect(current_path).to eq company_employee_path(CompanyEmployee.last)
        expect(page).to have_content('Perfil salvo com sucesso!')
        expect(page).to have_content('Maria Silva Lima')
        expect(page).to have_content('Maria Lima')
        expect(page).to have_content('17/08/1990')
        expect(page).to have_content('Recrutadora')
        expect(page).to have_content('RH')
        expect(page).to have_content('86368474009')
    end
end