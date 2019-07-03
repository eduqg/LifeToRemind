require 'rails_helper'

RSpec.feature "Plan", :type => :feature do
  let!(:user) {User.create!(email: 'usernormal@22.com', password: 'skdD.sk@#ffew2', name: 'user 2')}
  let!(:plan) {Plan.create!(name: "Normal Plan", user_id: user.id)}

  let!(:user_admin) {User.create!(email: 'admin2@admin2.com', password: 'skdD.sk@#ffew2', name: 'admin2', role: 'admin')}
  let!(:plan_admin) {Plan.create!(name: "Admin Plan", user_id: user_admin.id)}

  let!(:user_2) {User.create!(email: '22@22.com', password: 'skdD.sk@#ffew2', name: 'user 2')}
  let!(:plan_2) {Plan.create!(name: "2 Plan", user_id: user_2.id)}

  before :each do
    login_as(user, scope: :user)
    user.selected_plan = plan.id
    user.save
  end

  context 'integration Privilege Escalation validations' do

    it 'default user can access all his plans' do
      visit 'plans/'
      expect(page).to have_css('#card_plan', count: 1)
    end

    it 'default user cannot edit another user-s plan' do
      visit 'plans/' + (plan_2.id).to_s + '/edit'
      expect(page).to have_content('You are not authorized to access this page.')
    end

    it 'default user can edit his own plan' do
      visit 'plans/' + (plan.id).to_s + '/edit'
      expect(page).to have_content('Nome do plano')
    end

    it 'user cannot access another user pdf' do
      visit 'plans/pdf.pdf?id=' + (plan_2.id).to_s
      expect(page).to have_content('You are not authorized to access this page.')
    end
  end

  context 'Crud integration' do
    it 'user can create plan' do
      visit '/plans'
      click_link 'button-create-plan'
      fill_in 'plan_name', with: 'plan 1'
      click_button 'Criar'
      expect(page).to have_content('Plano criado com sucesso')
    end

    it 'user can edit plan' do
      visit '/plans'
      click_link 'button-create-plan'
      fill_in 'plan_name', with: 'plan 1'
      click_button 'Criar'
      visit '/plans'
      click_link 'button-edit-plan'
      fill_in 'plan_name', with: 'planao atualizadao 2'
      click_button 'Criar'
      expect(page).to have_content('Plano atualizado com sucesso')
    end

    it 'user can view his plan on editplan page' do
      visit '/plans'
      click_link 'button-create-plan'
      fill_in 'plan_name', with: 'plan 112'
      click_button 'Criar'
      visit '/plans'
      expect(page).to have_content('plan 112')
    end

    it 'user can delete his plan' do
      visit '/plans'
      click_link 'button-create-plan'
      fill_in 'plan_name', with: 'plan 112'
      click_button 'Criar'
      visit '/plans'
      click_link 'button-delete-plan'
      expect(page).to have_content('Plano foi excluído')
    end
  end
end

