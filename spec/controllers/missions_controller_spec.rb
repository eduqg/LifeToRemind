require 'rails_helper'

RSpec.describe MissionsController, type: :controller do
  let!(:mission) {FactoryBot.create(:mission)}
  let!(:user) {User.find(mission.user_id)}
  let!(:plan) {Plan.create!(name:"My incredible plan", user_id: user.id)}

  let(:valid_attributes) {{ why_exist: "why", purpose_of_life:"purpose", who_am_i:"who", user_id: user.id}}

  let(:invalid_attributes) {{ purpose_of_life:"purpose", who_am_i:"who", user_id: user.id }}

  let(:valid_session) {{}}

  before :each do
    sign_in user
    user.selected_plan = plan.id
    user.save
  end

  context "GET #index" do
    it "return index success response" do
      get :index
      expect(response).to be_successful
    end
  end

  context "GET #new" do
    it "assigns a new" do
      get :new, valid_session
      expect(response).to be_successful
    end
  end

  context "GET #edit" do
    it "assigns edit" do
      get :edit, params: { use_route: "missions/", id: mission.id }
      expect(response.status).to eq(200)
    end
  end

  context "GET #create" do
    it "creates an Mission" do
      expect {
        post :create, params: {mission: valid_attributes}
      }.to change(Mission, :count).by(1)

    end

    it "assigns a newly created mission as @mission" do
      post :create, params: {mission: valid_attributes}
      expect(assigns(:mission)).to be_a(Mission)
      expect(assigns(:mission)).to be_persisted
    end

    it "not create an mission" do
      expect {
        post :create, params: {mission: invalid_attributes}
      }.to change(Mission, :count).by(0)
    end

    it "redirects to new mission if invalid attributes" do
      post :create, params: {mission: invalid_attributes}
      assert_template :new
      # Works too: expect(response).to render_template("new")
    end

    it "redirects to index after create mission" do
      post :create, params: {mission: valid_attributes}
      expect(response).to redirect_to(missions_path)
    end
  end

  context "GET #update" do
    it "updates an mission" do
      mission_to_update = Mission.create! valid_attributes
      put :update, params: {id: mission_to_update.to_param, mission: {why_exist: "Porque existo atualizado", user_id: user.id}}
      mission_to_update.reload
      expect(mission_to_update.why_exist).to match("Porque existo atualizado")
    end

    it "fails to update a mission" do
      mission_to_update = Mission.create! valid_attributes
      put :update, params: {id: mission_to_update.to_param, mission: {user_id: user.id}}
      mission_to_update.reload
      expect(mission_to_update.why_exist).not_to match("A")
    end

    it "redirects to edit update if invalid attributes" do
      mission_to_update = Mission.create! valid_attributes
      put :update, params: {id: mission_to_update.to_param, mission: {why_exist: nil}}
      assert_template :edit
    end

    it "redirects to missions after update mission" do
      mission_to_update = Mission.create! valid_attributes
      put :update, params: {id: mission_to_update.to_param, mission: {why_exist: "Porque existo atualizado",}}
      expect(response).to redirect_to(missions_path)
    end
  end

  context "DELETE #destroy" do
    it "destroy the requested mission" do
      mission_to_destroy = Mission.create! valid_attributes
      expect {
        delete :destroy, params: {id: mission_to_destroy.id}
      }.to change(Mission, :count).by(-1)
    end
    it "redirects to missions after update mission" do
      mission_to_destroy = Mission.create! valid_attributes
      delete :destroy, params: {id: mission_to_destroy.to_param}
      expect(response).to redirect_to(missions_path)
    end
    it "set current_mission to nil after destroy" do
      mission_to_destroy = Mission.create! valid_attributes
      plan.selected_mission = mission_to_destroy.id
      plan.save
      delete :destroy, params: {id: mission_to_destroy.to_param}
      plan.reload
      expect(plan.selected_mission).to eq(nil)
    end
  end

  context "PUT #update_selected_mission" do
    it "should not update without selected plan" do
      user.selected_plan = nil
      user.save
      put :update_selected_mission, params: {mission_id: mission.id}
      plan.reload
      expect(flash[:info]).to match(/Missão selecionada não pode ser atualizada.*/)
    end

    it "should update selected mission on plan" do
      plan.selected_mission = nil
      plan.save
      put :update_selected_mission, params: {mission_id: mission.id}
      plan.reload
      expect(plan.selected_mission).to eq(mission.id)
    end
  end
end
