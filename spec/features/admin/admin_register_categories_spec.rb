require 'rails_helper'

feature 'Admin register categories' do
  scenario 'successfully' do
    admin = create(:user, role: :admin)

    login_as admin, scope: :user
    visit root_path
    click_on 'Categorias'
    click_on 'Nova Categoria'

    fill_in 'Nome', with: 'A'
    fill_in 'Diária padrão', with: 100
    fill_in 'Seguro padrão do carro', with: 500
    fill_in 'Seguro padrão contra terceiros', with: 300
    click_on 'Enviar'
    
    expect(page).to have_content('Categoria: A')
    expect(page).to have_content(100)
    expect(page).to have_content(500)
    expect(page).to have_content(300)
  end

  scenario 'failure' do
    admin = create(:user, role: :admin)

    login_as admin, scope: :user
    visit root_path
    click_on 'Categorias'
    click_on 'Nova Categoria'

    fill_in 'Nome', with: ''
    fill_in 'Diária padrão', with: 100
    fill_in 'Seguro padrão do carro', with: 500
    fill_in 'Seguro padrão contra terceiros', with: 300
    click_on 'Enviar'
    

    expect(page).to have_content('Erro, todos os dados devem ser preenchidos')
    expect(page).to have_field('Diária padrão')
  end

  scenario 'admin edit category' do
    admin = create(:user, role: :admin)
    category = create(:category, name: 'A', daily_rate: 150, car_insurance: 500, third_party_insurance: 300)
    login_as admin, scope: :user

    visit root_path
    click_on 'Categorias'
    click_on category.name
    click_on 'Editar Categoria'

    fill_in 'Nome', with: 'B'
    fill_in 'Diária padrão', with: 150
    fill_in 'Seguro padrão do carro', with: 200
    click_on 'Enviar'
    
    expect(page).to have_content('Categoria: B')
    expect(page).to have_content('R$ 150,00')
    expect(page).to have_content('R$ 200,00')
    expect(page).to have_content('R$ 300,00')
  end
end