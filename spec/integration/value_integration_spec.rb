require 'rails_helper'

RSpec.feature "Value", :type => :feature do
  let!(:value) {FactoryBot.create(:value)}
  let!(:plan) {Plan.find(value.plan_id)}
  let!(:user) {User.find(plan.user_id)}

  let!(:user_2) {User.create!(email: 'user2@user2.com', password: 'skdD.sk@#ffe2w2', name: 'user2')}
  let!(:plan_2) {Plan.create!(name:"User 2 Plan", user_id: user_2.id)}
  let!(:value_2) {Value.create!(name: "Really Normal value 1", plan_id: plan_2.id)}

  before :each do
    login_as(user_2, scope: :user)
    user_2.selected_plan = plan_2.id
    user_2.save
  end

  context 'integration Privilege Escalation validations' do
    it 'default user can access all of his values' do
      visit 'values/'
      expect(page).to have_css('#card_of_value', count: 1)
    end

    it 'default user cannot edit another user-s value' do
      visit 'values/'+ (value.id).to_s + '/edit'
      expect(page).to have_content('You are not authorized to access this page.')
    end

    it 'default user can edit his own value' do
      visit 'values/'+ (value_2.id).to_s + '/edit'
      expect(page).to have_content 'Edição de valor'
    end
  end

  context 'Crud integration' do
    it 'user can create value' do
      visit 'values/new'
      fill_in 'value_name', with: 'value 1'
      click_button 'button-create-value'
      expect(page).to have_content('Valor foi criado com sucesso')
    end

    it 'user can edit value' do
      visit 'values/' + (value_2.id).to_s + '/edit'
      fill_in 'value_name', with: 'edit value 222aaa'
      click_button 'button-create-value'
      expect(page).to have_content('Valor foi atualizado com sucesso')
    end

    it 'user can view his value on myplan' do
      visit 'values/' + (value_2.id).to_s + '/edit'
      fill_in 'value_name', with: 'edit value 222aaa'
      click_button 'button-create-value'
      visit '/myplan'
      expect(page).to have_content('edit value 222aaa')
    end

    it 'user can delete his value' do
      visit '/values'
      click_link 'delete-value'
      expect(page).to have_content('Valor foi excluído')
    end
  end
end

