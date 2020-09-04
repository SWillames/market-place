require 'rails_helper'

feature 'User sign in' do
    scenario 'from home page' do
        visit root_path
        expect(page).to have_link('Entrar')
    end

    scenario 'successfully' do
        User.create!(name: 'Tatiana Oliveira', email:'tatiana@email.com', 
                     password: '12345678')
        visit root_path
        click_on 'Entrar'
        fill_in 'Email', with: "tatiana@email.com"
        fill_in 'Senha', with: "12345678"
        click_on 'Entrar'

        expect(page).to have_content 'Tatiana Oliveira'
        expect(page).to have_content 'Login efetuado com sucesso'
        expect(page).to have_link 'Sair'
        expect(page).not_to have_link 'Entrar'
        
    end

    scenario 'and sign out' do
        user = User.create!(name: 'Tatiana Oliveira', email:'tatiana@email.com', 
                            password: '12345678')

        login_as(user, scope: :user)
        visit root_path
        click_on 'Sair'

        expect(current_path).to eq root_path
        expect(page).to have_content 'Saiu com sucesso.'
        expect(page).to have_link 'Entrar'
        expect(page).not_to have_link 'Sair'
                
    end
end

