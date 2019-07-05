require 'rails_helper'

RSpec.feature "Plan", :type => :feature do
  let!(:user) {User.create!(email: 'usernormal@22.com', password: 'skdD.sk@#ffew2', name: 'user 2')}

  let!(:user_2) {User.create!(email: '22@22.com', password: 'skdD.sk@#ffew2', name: 'user 2')}
  let!(:plan_2) {Plan.create!(name: "2 Plan", user_id: user_2.id)}

  before :each do
    login_as(user, scope: :user)
    visit '/plans'
    click_link 'load-plans'
    attach_file("file", "#{Rails.root}/spec/fixtures/valid_simple_file_test.json")
    click_button 'file-plans-submit'
    visit '/plans'
    click_link 'button-select-plan'
  end

  context "Content of imported json user access" do
    it 'should have saved mission' do
      visit '/myplan'
      click_link 'button-missions-cog'
      expect(page).to have_content('Eu sou uma pessoa')
    end

    it 'should have saved vision' do
      visit '/myplan'
      click_link 'button-visions-cog'
      expect(page).to have_content('Eu vou para')
    end

    it 'should have saved csf' do
      visit '/myplan'
      click_link 'button-csfs-cog'
      expect(page).to have_content('Minhas competências são')
    end

    it 'should have swotpart' do
      visit '/myplan'
      expect(page).to have_content('Minha força 1')
    end

    it 'should have value' do
      visit '/myplan'
      expect(page).to have_content('Meu valorzão')
    end

    it 'should have role' do
      visit '/myplan'
      expect(page).to have_content('ser dahora')
    end

    it 'should have sphere' do
      visit '/myplan'
      expect(page).to have_content('Meu Âmbito 1')
    end

    it 'should have objective' do
      visit '/myplan'
      expect(page).to have_content('Meu objetivão')
    end

    it 'should have goal' do
      visit '/myplan'
      expect(page).to have_content('Minha grande meta')
    end
  end

  context "Content of imported json other user access" do
    it 'shouldn-t have saved mission' do
      logout(:user)
      login_as(user_2, scope: :user)
      user_2.selected_plan = plan_2.id
      user_2.save
      visit '/missions'
      expect(page).not_to have_content('Eu sou uma pessoa')
    end

    it 'shouldn-t have saved vision' do
      logout(:user)
      login_as(user_2, scope: :user)
      user_2.selected_plan = plan_2.id
      user_2.save
      visit '/visions'
      expect(page).not_to have_content('Eu vou para')
    end

    it 'shouldn-t have saved csf' do
      logout(:user)
      login_as(user_2, scope: :user)
      user_2.selected_plan = plan_2.id
      user_2.save
      visit '/csfs'
      expect(page).not_to have_content('Minhas competências são')
    end

    it 'shouldn-t have sphere' do
      logout(:user)
      login_as(user_2, scope: :user)
      user_2.selected_plan = plan_2.id
      user_2.save
      visit '/spheres'
      expect(page).not_to have_content('Meu Âmbito 1')
    end

    it 'shouldn-t have swotpart' do
      logout(:user)
      login_as(user_2, scope: :user)
      user_2.selected_plan = plan_2.id
      user_2.save
      visit '/myplan'
      expect(page).not_to have_content('Minha força 1')
    end

    it 'shouldn-t have value' do
      logout(:user)
      login_as(user_2, scope: :user)
      user_2.selected_plan = plan_2.id
      user_2.save
      visit '/myplan'
      expect(page).not_to have_content('Meu valorzão')
    end

    it 'shouldn-t have role' do
      logout(:user)
      login_as(user_2, scope: :user)
      user_2.selected_plan = plan_2.id
      user_2.save
      visit '/myplan'
      expect(page).not_to have_content('ser dahora')
    end

    it 'shouldn-t have objective' do
      logout(:user)
      login_as(user_2, scope: :user)
      user_2.selected_plan = plan_2.id
      user_2.save
      visit '/myplan'
      expect(page).not_to have_content('Meu objetivão')
    end

    it 'shouldn-t have goal' do
      logout(:user)
      login_as(user_2, scope: :user)
      user_2.selected_plan = plan_2.id
      user_2.save
      visit '/myplan'
      expect(page).not_to have_content('Minha grande meta')
    end
  end
end

