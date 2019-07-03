require 'rails_helper'

RSpec.feature "Swotpart", :type => :feature do
  let!(:swotpart) {FactoryBot.create(:swotpart)}
  let!(:plan) {Plan.find(swotpart.plan_id)}
  let!(:user) {User.find(plan.user_id)}

  let!(:user_admin) {User.create!(email: 'admin2@admin2.com', password: 'skdD.sk@#ffew2', name: 'admin2', role: 'admin')}
  let!(:plan_admin) {Plan.create!(name: "Admin Plan", user_id: user_admin.id)}
  let!(:swotpart_admin) {Swotpart.create!(name: "Força do Admin", partname: "strength", plan_id: plan_admin.id)}

  let!(:user_2) {User.create!(email: 'user2@user2.com', password: 'skdD.sk@#ffe2w2', name: 'user2')}
  let!(:plan_2) {Plan.create!(name: "User 2 Plan", user_id: user_2.id)}
  let!(:swotpart_2) {Swotpart.create!(name: "Força do User 2", partname: "strength", plan_id: plan_2.id)}

  before :each do
    login_as(user, scope: :user)
    user.selected_plan = plan.id
    user.save
  end

  context 'integration Privilege Escalation validations' do

    it 'default user cannot access all swotparts' do
      visit 'swotparts/'
      expect(page).to have_content('You are not authorized to access this page.')
    end

    it 'default user can acess swotedit' do
      visit 'plans/swotedit'
      expect(page).to have_content('O primeiro passo para ajudar na criação do seu planejamento estratégico pessoal')
    end

    it 'admin user can access all swotparts' do
      logout(:user)
      login_as(user_admin, scope: :user)
      user_admin.selected_plan = plan_admin.id
      user_admin.save
      visit 'swotparts/'
      expect(page).to have_content 'Page Swotparts'
    end

    it 'default user cannot edit another user-s swotpart' do
      visit 'swotparts/' + (swotpart_2.id).to_s + '/edit'
      expect(page).to have_content('You are not authorized to access this page.')
    end

    it 'default user can edit his own swotpart' do
      visit 'swotparts/' + (swotpart.id).to_s + '/edit'
      expect(page).to have_content 'Edição de campo'
    end
  end

  context 'Crud integration' do
    it 'user can create swotpart' do
      visit '/plans/swotedit'
      fill_in 'field-Oportunidade', with: 'uma oportunidade'
      click_button 'add-Oportunidade'
      expect(page).to have_content('uma oportunidade')
    end

    it 'user can edit swotpart' do
      visit '/plans/swotedit'
      fill_in 'field-Oportunidade', with: 'uma oportunidade'
      click_button 'add-Oportunidade'
      visit '/plans/swotedit'
      click_link 'edit-opportunity'
      fill_in 'swotpart_name', with: 'name 2'
      click_button 'Atualizar'
      expect(page).to have_content('Característica da SWOT atualizada com sucesso')

    end

    it 'user can view his swotpart on myplan' do
      visit '/plans/swotedit'
      fill_in 'field-Oportunidade', with: 'uma oportunidade asd'
      click_button 'add-Oportunidade'
      visit '/myplan'
      expect(page).to have_content('uma oportunidade asd')
    end

    it 'user can delete his swotpart' do
      visit '/plans/swotedit'
      fill_in 'field-Oportunidade', with: 'uma oportunidade'
      click_button 'add-Oportunidade'
      click_link 'delete-opportunity'
      expect(page).to have_content('opportunity removida')
    end
  end
end

