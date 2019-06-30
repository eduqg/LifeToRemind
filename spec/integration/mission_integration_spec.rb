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
      expect(page).to have_content('Você não pode editar essa missão')

    end

    it 'default user can edit his own mission' do
      visit 'missions/'+ (mission.id).to_s + '/edit'
      expect(page).to have_content 'Edição de Missão'
    end
  end
end

