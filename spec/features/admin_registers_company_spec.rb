require 'rails_helper'

feature 'Admin registers company' do
    scenario 'successfully' do
        visit root_path
        click_on 'Empresas'
        click_on 'Registrar nova empresa'

        fill_in 'Nome', with: 'Empresa01'
        fill_in 'Razão social', with: 'Empresa01 LTDA'
        fill_in 'CNPJ', with: '13433548000177'
        fill_in 'Endereço', with: 'Rua Vergueiro,100'
        fill_in 'Redes sociais', with: '@empresa01'
        fill_in 'Domínio', with: '@empresa01.com'
        click_on 'Cadastrar'
        
        expect(current_path).to eq company_path(Company.last)
        expect(page).to have_content('Empresa cadastrada com sucesso!')
        expect(page).to have_content('Empresa01')
        expect(page).to have_content('Empresa01 LTDA')
        expect(page).to have_content('13433548000177')
        expect(page).to have_content('Rua Vergueiro,100')
        expect(page).to have_content('@empresa01')
        expect(page).to have_content('@empresa01.com')
    end
end