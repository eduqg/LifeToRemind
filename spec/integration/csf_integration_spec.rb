require 'rails_helper'

RSpec.feature "Csf", :type => :feature do
  let!(:csf) {FactoryBot.create(:csf)}
  let!(:user) {User.find(csf.user_id)}
  let!(:plan) {Plan.create!(name: "My incredible plan", user_id: user.id)}

  let!(:user_2) {User.create!(email: 'user2@user2.com', password: 'skdD.sk@#ffe2w2', name: 'user2')}
  let!(:plan_2) {Plan.create!(name: "User 2 Plan", user_id: user_2.id)}
  let!(:csf_2) {Csf.create!(what_makes_me_unique: "where", best_attributes: "how", essential_atributes: "sdlkmsdkfm", health_factors: "slkmsdfk", user_id: user_2.id)}

  before :each do
    login_as(user, scope: :user)
    user.selected_plan = plan.id
    user.save
  end

  context 'integration Privilege Escalation validations' do
    it 'user can only see his own csfs' do
      visit 'csfs/'
      expect(page).to have_content('Quais minhas melhores competências?', count: 1)
    end

    it 'default user cannot edit another user-s swotpart' do
      visit 'csfs/' + (csf_2.id).to_s + '/edit'
      expect(page).to have_content('You are not authorized to access this page.')
    end

    it 'default user can edit his own csf' do
      visit 'csfs/' + (csf.id).to_s + '/edit'
      expect(page).to have_content 'Edição de Fatores Críticos de Sucesso'
    end
  end

  context 'Crud integration' do
    it 'user can create csf' do
      visit 'csfs/new'
      fill_in 'csf_what_makes_me_unique', with: 'unique'
      fill_in 'csf_best_attributes', with: 'best'
      fill_in 'csf_essential_atributes', with: 'essential'
      fill_in 'csf_health_factors', with: 'health'
      click_button 'Criar'
      expect(page).to have_content('O Fator Crítico de Sucesso criado foi adicionada ao seu planejamento')
    end

    it 'user can edit csf' do
      visit 'csfs/' + (csf.id).to_s + '/edit'
      fill_in 'csf_what_makes_me_unique', with: 'unique'
      fill_in 'csf_best_attributes', with: 'best'
      fill_in 'csf_essential_atributes', with: 'essential'
      fill_in 'csf_health_factors', with: 'health'
      click_button 'Atualizar'
      expect(page).to have_content('Fator crítico de sucesso atualizado')
    end

    it 'user can view his csf on myplan' do
      visit 'csfs/new'
      fill_in 'csf_what_makes_me_unique', with: 'unique'
      fill_in 'csf_best_attributes', with: 'best'
      fill_in 'csf_essential_atributes', with: 'essential'
      fill_in 'csf_health_factors', with: 'health'
      click_button 'Criar'
      visit '/myplan'
      expect(page).to have_content('unique')
    end

    it 'user can delete his csf' do
      visit '/csfs'
      click_link 'Remover'
      expect(page).to have_content('Fator crítico de sucesso foi excluído')
    end

  end
end

