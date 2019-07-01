require 'rails_helper'

RSpec.feature "Mission", :type => :feature do
  let!(:mission) {FactoryBot.create(:mission)}
  let!(:user) {User.find(mission.user_id)}
  let!(:plan) {Plan.create!(name:"My incredible plan", user_id: user.id)}

  let!(:user_2) {User.create!(email: 'user2@user2.com', password: 'skdD.sk@#ffe2w2', name: 'user2')}
  let!(:plan_2) {Plan.create!(name:"User 2 Plan", user_id: user_2.id)}
  let!(:mission_2) {Mission.create!(why_exist: "why", purpose_of_life:"purpose", who_am_i:"who", user_id: user_2.id)}

  before :each do
    login_as(user, scope: :user)
    user.selected_plan = plan.id
    user.save
  end

  context 'integration Privilege Escalation validations' do
    it 'user can only see his own missions' do
      visit 'missions/'
      expect(page).to have_content('Quem eu sou', count: 1)
    end

    it 'default user cannot edit another user-s swotpart' do
      visit 'missions/'+ (mission_2.id).to_s + '/edit'
      expect(page).to have_content('You are not authorized to access this page.')

    end

    it 'default user can edit his own mission' do
      visit 'missions/'+ (mission.id).to_s + '/edit'
      expect(page).to have_content 'Edição de Missão'
    end

    it 'user can create mission' do
      visit 'missions/new'
      fill_in 'mission_who_am_i', with: 'who222'
      fill_in 'mission_why_exist', with: 'why22'
      fill_in 'mission_purpose_of_life', with: 'purpose'
      click_button 'Criar'
      expect(page).to have_content('A Missão criada foi adicionada ao seu planejamento')
    end

    it 'user can edit mission' do
      visit 'missions/' + (mission.id).to_s + '/edit'
      fill_in 'mission_who_am_i', with: 'who222aaa'
      fill_in 'mission_why_exist', with: 'why22aa'
      fill_in 'mission_purpose_of_life', with: 'purposea'
      click_button 'Atualizar'
      expect(page).to have_content('Missão atualizada com sucesso!')
    end

    it 'user can view his mission on myplan' do
      visit 'missions/new'
      fill_in 'mission_who_am_i', with: 'who222'
      fill_in 'mission_why_exist', with: 'why22'
      fill_in 'mission_purpose_of_life', with: 'purpose'
      click_button 'Criar'
      visit '/myplan'
      expect(page).to have_content('who222')
    end

    it 'user can delete his mission' do
      visit '/missions'
      click_link 'Remover'
      expect(page).to have_content('Missão foi excluída')
    end

  end
end

