require 'rails_helper'

RSpec.feature "Value", :type => :feature do
  let!(:value) {FactoryBot.create(:value)}
  let!(:plan) {Plan.find(value.plan_id)}
  let!(:user) {User.find(plan.user_id)}

  let!(:user_2) {User.create!(email: 'user2@user2.com', password: 'skdD.sk@#ffe2w2', name: 'user2')}
  let!(:plan_2) {Plan.create!(name:"User 2 Plan", user_id: user_2.id)}
  let!(:value_2) {Value.create!(name: "Really Normal value 1", plan_id: plan_2.id)}
  let!(:value_3) {Value.create!(name: "Really Normal value 2", plan_id: plan_2.id)}

  before :each do
    login_as(user_2, scope: :user)
    user_2.selected_plan = plan_2.id
    user_2.save
  end

  context 'integration Privilege Escalation validations' do
    it 'default user can access all of his values' do
      visit 'values/'
      expect(page).to have_css('#card_of_value', count: 2)
    end

    it 'default user cannot edit another user-s value' do
      visit 'values/'+ (value.id).to_s + '/edit'
      expect(page).to have_content('Você não pode editar esse valor')
    end

    it 'default user can edit his own value' do
      visit 'values/'+ (value_3.id).to_s + '/edit'
      expect(page).to have_content 'Edição de valor'
    end


  end
end

