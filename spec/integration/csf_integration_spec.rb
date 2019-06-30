require 'rails_helper'

RSpec.feature "Csf", :type => :feature do
  let!(:csf) {FactoryBot.create(:csf)}
  let!(:user) {User.find(csf.user_id)}
  let!(:plan) {Plan.create!(name:"My incredible plan", user_id: user.id)}

  let!(:user_2) {User.create!(email: 'user2@user2.com', password: 'skdD.sk@#ffe2w2', name: 'user2')}
  let!(:plan_2) {Plan.create!(name:"User 2 Plan", user_id: user_2.id)}
  let!(:csf_2) {Csf.create!(what_makes_me_unique: "where", best_attributes: "how", essential_atributes: "sdlkmsdkfm", health_factors:"slkmsdfk", user_id: user_2.id)}

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
      expect{ visit 'csfs/'+ (csf_2.id).to_s + '/edit'}.to raise_error(CanCan::AccessDenied)
    end

    it 'default user can edit his own csf' do
      visit 'csfs/'+ (csf.id).to_s + '/edit'
      expect(page).to have_content 'Edição de Fatores Críticos de Sucesso'
    end
  end
end

