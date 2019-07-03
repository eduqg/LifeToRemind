require 'rails_helper'

RSpec.feature "Vision", :type => :feature do
  let!(:vision) {FactoryBot.create(:vision)}
  let!(:user) {User.find(vision.user_id)}
  let!(:plan) {Plan.create!(name: "My incredible plan", user_id: user.id)}

  let!(:user_2) {User.create!(email: 'user2@user2.com', password: 'skdD.sk@#ffe2w2', name: 'user2')}
  let!(:plan_2) {Plan.create!(name: "User 2 Plan", user_id: user_2.id)}
  let!(:vision_2) {Vision.create!(where_im_going: "where1", where_arrive: "where", how_complete_mission: "how", user_id: user_2.id)}

  before :each do
    login_as(user, scope: :user)
    user.selected_plan = plan.id
    user.save
  end

  context 'integration Privilege Escalation validations' do
    it 'user can only see his own visions' do
      visit 'visions/'
      expect(page).to have_content('Onde quero chegar?', count: 1)
    end

    it 'default user cannot edit another user-s swotpart' do
      visit 'visions/' + (vision_2.id).to_s + '/edit'
      expect(page).to have_content('You are not authorized to access this page.')
    end

    it 'default user can edit his own vision' do
      visit 'visions/' + (vision.id).to_s + '/edit'
      expect(page).to have_content 'Edição de Visão'
    end
  end

  context 'Crud integration' do
    it 'user can create vision' do
      visit 'visions/new'
      fill_in 'vision_where_im_going', with: 'where222'
      fill_in 'vision_where_arrive', with: 'arrive22'
      fill_in 'vision_how_complete_mission', with: 'how'
      click_button 'Criar'
      expect(page).to have_content('A Visão criada foi adicionada ao seu planejamento')
    end

    it 'user can edit vision' do
      visit 'visions/' + (vision.id).to_s + '/edit'
      fill_in 'vision_where_im_going', with: 'where222'
      fill_in 'vision_where_arrive', with: 'arrive22'
      fill_in 'vision_how_complete_mission', with: 'how'
      click_button 'Atualizar'
      expect(page).to have_content('Visão atualizada com sucesso!')
    end

    it 'user can view his vision on myplan' do
      visit 'visions/new'
      fill_in 'vision_where_im_going', with: 'where222'
      fill_in 'vision_where_arrive', with: 'arrive22'
      fill_in 'vision_how_complete_mission', with: 'how'
      click_button 'Criar'
      visit '/myplan'
      expect(page).to have_content('where222')
    end

    it 'user can delete his vision' do
      visit '/visions'
      click_link 'Remover'
      expect(page).to have_content('Visão foi excluída')
    end
  end
end

