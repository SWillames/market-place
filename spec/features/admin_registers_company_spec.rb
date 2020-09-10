require 'rails_helper'

feature 'Admin registers company' do
    xscenario 'successfully' do
        user = User.create!(name: 'Marco Lima', email:'marco@empresa01.com.br', 
                            password: '12345678')

        login_as user, scope: :user
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

    xscenario 'and attributes cannot be blank' do
        user = User.create!(name: 'Marco Lima', email:'marco@empresa01.com.br', 
        password: '12345678')
        
        login_as user, scope: :user
        visit root_path
        click_on 'Empresas'
        click_on 'Registrar nova empresa'

        fill_in 'Nome', with: ''
        fill_in 'Razão social', with: ''
        fill_in 'CNPJ', with: ''
        fill_in 'Endereço', with: ''
        fill_in 'Redes sociais', with: ''
        fill_in 'Domínio', with: ''
        click_on 'Cadastrar'
        
        expect(page).to have_content('Nome não pode ficar em branco')
        expect(page).to have_content('Razão social não pode ficar em branco')
        expect(page).to have_content('CNPJ não pode ficar em branco')
        expect(page).to have_content('Endereço não pode ficar em branco')
        expect(page).to have_content('Redes sociais não pode ficar em branco')
        expect(page).to have_content('Domínio não pode ficar em branco')
    end

    xscenario 'cnpj must be valid' do
        user = User.create!(name: 'Marco Lima', email:'marco@empresa01.com.br', 
                            password: '12345678')
        
        login_as user, scope: :user
        visit root_path
        click_on 'Empresas'
        click_on 'Registrar nova empresa'

        fill_in 'Nome', with: 'Empresa01'
        fill_in 'Razão social', with: 'Empresa01 LTDA'
        fill_in 'CNPJ', with: '12345678910123'
        fill_in 'Endereço', with: 'Rua Vergueiro,100'
        fill_in 'Redes sociais', with: '@empresa01'
        fill_in 'Domínio', with: '@empresa01.com'
        click_on 'Cadastrar'
        
        expect(page).to have_content('CNPJ inválido')
    end

    xscenario 'cnpj must be unique' do
        user = User.create!(name: 'Marco Lima', email:'marco@empresa01.com.br', 
                            password: '12345678')
        
        company = Company.create!(name: 'Empresa01', legal_name:'Empresa01 LTDA', cnpj: '98922455000169',
                                  address:'Rua nada, 100', social_media:'linkedin', domain:'@empresa01.com.br')
        login_as user, scope: :user
        visit root_path
        click_on 'Empresas'
        click_on 'Registrar nova empresa'

        fill_in 'Nome', with: 'Empresa01'
        fill_in 'Razão social', with: 'Empresa01 LTDA'
        fill_in 'CNPJ', with: '98922455000169'
        fill_in 'Endereço', with: 'Rua Vergueiro,100'
        fill_in 'Redes sociais', with: '@empresa01'
        fill_in 'Domínio', with: '@empresa01.com'
        click_on 'Cadastrar'
        click_on 'Cadastrar'
        
        expect(page).to have_content('CNPJ já está em uso')
    end
end