require 'rails_helper'

RSpec.feature "Objective", :type => :feature do
  let!(:objective) {FactoryBot.create(:objective)}
  let!(:plan) {Plan.find(objective.plan_id)}
  let!(:user) {User.find(plan.user_id)}

  let!(:user_admin) {User.create!(email: 'admin2@admin2.com', password: 'skdD.sk@#ffew2', name: 'admin2', role: 'admin')}
  let!(:plan_admin) {Plan.create!(name:"Admin Plan", user_id: user_admin.id)}
  let!(:sphere_admin) {Sphere.create!(name: "ReallyNormalName", user_id: user_admin.id)}
  let!(:objective_admin) {Objective.create!(name: "My Objective", plan_id: plan_admin.id, sphere_id: sphere_admin.id)}

  let!(:user_2) {User.create!(email: '22@22.com', password: 'skdD.sk@#ffew2', name: 'user 2')}
  let!(:plan_2) {Plan.create!(name:"2 Plan", user_id: user_2.id)}
  let!(:sphere_2) {Sphere.create!(name: "ReallyNormalName", user_id: user_2.id)}
  let!(:objective_2) {Objective.create!(name: "My Objective", plan_id: plan_2.id, sphere_id: sphere_2.id)}

  before :each do
    login_as(user, scope: :user)
    user.selected_plan = plan.id
    user.save
  end

  context 'integration Privilege Escalation validations' do

    it 'default user cannot access all objectives' do
      visit 'objectives/'
      expect(page).to have_content('You are not authorized to access this page.')
    end

    it 'admin user can access all objectives' do
      logout(:user)
      login_as(user_admin, scope: :user)
      user_admin.selected_plan = plan_admin.id
      user_admin.save
      visit 'objectives/'
      expect(page).to have_content 'Meus objetivos'
    end

    it 'default user cannot edit another user-s objective' do
      visit 'objectives/'+ (objective_2.id).to_s + '/edit'
      expect(page).to have_content('You are not authorized to access this page.')
    end

    it 'default user can edit his own objective' do
      visit 'objectives/'+ (objective.id).to_s + '/edit'
      expect(page).to have_content('Editar Objetivo Estratégico')
    end

    it 'default user cannot access show' do
      visit 'objectives/'+ (objective.id).to_s
      expect(page).to have_content('You are not authorized to access this page.')
    end

    it 'default user cannot access other-s objective' do
      visit 'editobjective?objective_id='+ (objective_2.id).to_s
      expect(page).to have_content('Você não pode acessar esse objetivo')
    end

    it 'default user can access own objective' do
      visit 'editobjective?objective_id='+ (objective.id).to_s
      expect(page).to have_content('As atividades servem para acompanhar o progresso de uma meta')
    end
  end

  context 'Crud integration' do
    it 'user can create objective' do
      visit 'spheres/new'
      fill_in 'sphere_name', with: 'ambito 1'
      click_button 'Criar'
      visit '/myplan'
      click_link 'button-create-objective'
      fill_in 'objective_name', with: 'objective 222'
      select 'ambito 1', from: 'objective_sphere_id'
      click_button 'Criar'
      expect(page).to have_content('Objetivo foi adicionado ao seu planejamento, adicone Metas e Atividades em Meu Planejamento')
    end

    it 'user can edit objective' do
      visit '/spheres/new'
      fill_in 'sphere_name', with: 'ambito 2'
      click_button 'Criar'
      visit '/editobjective?objective_id=' + (objective.id).to_s
      click_link 'button-edit-objective'
      fill_in 'objective_name', with: 'hello objective'
      select 'ambito 2', from: 'objective_sphere_id'
      click_button 'Editar'
      expect(page).to have_content('Objetivo foi atualizado com sucesso')
    end

    it 'user can view his objective on editobjective page' do
      visit 'spheres/new'
      fill_in 'sphere_name', with: 'ambito 1'
      click_button 'Criar'
      visit '/myplan'
      click_link 'button-create-objective'
      fill_in 'objective_name', with: 'objective 2212'
      select 'ambito 1', from: 'objective_sphere_id'
      click_button 'Criar'
      visit '/myplan'
      expect(page).to have_content('objective 2212')
    end

    it 'user can delete his objective' do
      visit '/editobjective?objective_id=' + (objective.id).to_s
      click_link 'button-delete-objective'
      expect(page).to have_content('Objetivo Estratégico foi excluído')
    end
  end
end

