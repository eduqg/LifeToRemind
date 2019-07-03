require 'rails_helper'

RSpec.feature "Sphere", :type => :feature do
  let!(:user) {User.create!(email: 'usernormal@22.com', password: 'skdD.sk@#ffew2', name: 'user 2')}
  let!(:plan) {Plan.create!(name:"Normal Plan", user_id: user.id)}
  let!(:sphere) {Sphere.create!(name: "ReallyNormalName", user_id: user.id)}

  let!(:user_admin) {User.create!(email: 'admin2@admin2.com', password: 'skdD.sk@#ffew2', name: 'admin2', role: 'admin')}
  let!(:plan_admin) {Plan.create!(name:"Admin Plan", user_id: user_admin.id)}
  let!(:sphere_admin) {Sphere.create!(name: "ReallyNormalName", user_id: user_admin.id)}

  let!(:user_2) {User.create!(email: '22@22.com', password: 'skdD.sk@#ffew2', name: 'user 2')}
  let!(:plan_2) {Plan.create!(name:"2 Plan", user_id: user_2.id)}
  let!(:sphere_2) {Sphere.create!(name: "ReallyNormalName", user_id: user_2.id)}

  before :each do
    login_as(user, scope: :user)
    user.selected_plan = plan.id
    user.save
  end

  context 'integration Privilege Escalation validations' do

    it 'default user can access all his spheres' do
      visit 'spheres/'
      expect(page).to have_css('#card_sphere', count: 1)
    end

    it 'default user cannot edit another user-s sphere' do
      visit 'spheres/'+ (sphere_2.id).to_s + '/edit'
      expect(page).to have_content('You are not authorized to access this page.')
    end

    it 'default user can edit his own sphere' do
      visit 'spheres/'+ (sphere.id).to_s + '/edit'
      expect(page).to have_content('Editar Âmbito')
    end

    it 'default user can acess other-s sphere' do
      visit 'sphereobjectives?sphere_id='+ (sphere_2.id).to_s
      expect(page).to have_content('Você não pode acessar esse âmbito')
    end

    it 'default user can acess own sphere' do
      visit 'sphereobjectives?sphere_id='+ (sphere.id).to_s
      expect(page).to have_content('Objetivos do Âmbito')
    end
  end

  context 'Crud integration' do
    it 'user can create sphere' do
      visit 'spheres/new'
      fill_in 'sphere_name', with: 'sphere222'
      click_button 'Criar'
      expect(page).to have_content('Âmbito foi criado com sucesso')
    end

    it 'user can edit sphere' do
      visit '/spheres/' + (sphere.id).to_s + '/edit'
      fill_in 'sphere_name', with: 'sphere222'
      click_button 'Criar'
      expect(page).to have_content('Âmbito foi atualizado com sucesso')
    end

    it 'user can view his sphere on myplan' do
      visit 'spheres/new'
      fill_in 'sphere_name', with: 'sphere222'
      click_button 'Criar'
      visit '/myplan'
      expect(page).to have_content('sphere222')
    end

    it 'user can delete his sphere' do
      visit '/spheres/'
      click_link 'button-delete-sphere'
      expect(page).to have_content('Âmbito foi excluído')
    end
  end
end

