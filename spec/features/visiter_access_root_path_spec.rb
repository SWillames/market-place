require 'rails_helper'

feature 'Visiter access web page' do
  scenario 'successfully' do
      visit root_path
      expect(page).to have_content('Bem vindo ao Market Place!')
  end
end