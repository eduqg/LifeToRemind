require 'rails_helper'

RSpec.describe ObjectivesController, type: :controller do
  let!(:objective) {FactoryBot.create(:objective)}
  let!(:sphere) {Sphere.find(objective.sphere_id)}
  let!(:plan) {Plan.find(objective.plan_id)}
  let!(:user) {User.find(plan.user_id)}

  let!(:user_admin) {User.create!(email: 'admin2@admin2.com', password: 'skdD.sk@#ffew2', name: 'admin2', role: 'admin')}
  let!(:plan_admin) {Plan.create!(name:"Admin Plan", user_id: user_admin.id)}
  let!(:sphere_admin) {Sphere.create!(name: "ReallyNormalName", user_id: user_admin.id)}
  let!(:objective_admin) {Objective.create!(name: "My Objective", plan_id: plan_admin.id, sphere_id: sphere_admin.id)}

  let!(:user_2) {User.create!(email: '22@22.com', password: 'skdD.sk@#ffew2', name: 'user 2')}
  let!(:plan_2) {Plan.create!(name:"2 Plan", user_id: user_2.id)}
  let!(:sphere_2) {Sphere.create!(name: "ReallyNormalName", user_id: user_2.id)}
  let!(:objective_2) {Objective.create!(name: "My Objective", plan_id: plan_2.id, sphere_id: sphere_2.id)}

  let(:valid_attributes) {{name: "My Objective", plan_id: plan.id, sphere_id: sphere.id}}

  let(:invalid_attributes) {{ plan_id: plan.id, sphere_id: sphere.id}}

  let(:update_attributes) {{name: "Meta atualizada", objective_id: objective.id}}

  let(:valid_session) {{}}

  before :each do
    sign_in user
    user.selected_plan = plan.id
    user.save
  end


  context "GET #index" do
    it "return index not success response" do
      get :index
      expect(response).to redirect_to(root_path)
    end

    it "return index success response if admin" do
      sign_out user
      sign_in user_admin
      user_admin.selected_plan = plan_admin.id
      user_admin.save
      get :index
      expect(response).to be_successful
    end
  end

  context "GET #show" do
    it "returns not show success response" do
      get :show, params: {id: objective.to_param}
      expect(response).to redirect_to(root_path)
    end

    it "returns show success response" do
      sign_out user
      sign_in user_admin
      user_admin.selected_plan = plan_admin.id
      user_admin.save
      get :show, params: {id: objective.to_param}
      expect(response).to be_successful
    end
  end

  context "GET #new" do
    it "assigns a new" do
      get :new, valid_session
    end
  end

  context "GET #create" do
    it "creates an Objective" do
      expect {
        post :create, params: {objective: valid_attributes}
      }.to change(Objective, :count).by(1)

    end

    it "assigns a newly created objective as @objective" do
      post :create, params: {objective: valid_attributes}
      expect(assigns(:objective)).to be_a(Objective)
      expect(assigns(:objective)).to be_persisted
    end

    it "not create an objective" do
      expect {
        post :create, params: {objective: invalid_attributes}
      }.to change(Objective, :count).by(0)
    end

    it "redirects to new objective if invalid attributes" do
      post :create, params: {objective: invalid_attributes}
      assert_template :new
      # Works too: expect(response).to render_template("new")
    end

    it "redirects to index after create objective" do
      post :create, params: {objective: valid_attributes}
      expect(response).to redirect_to(new_objective_path)
    end
  end

  context "GET #update" do
    it "updates an objective" do
      objective_to_update = Objective.create! valid_attributes
      put :update, params: {id: objective_to_update.to_param, objective: {name: "Meta atualizada", objective_id: objective.id}}
      objective_to_update.reload
      expect(objective_to_update.name).to match("Meta atualizada")
    end

    it "fails to update a objective" do
      objective_to_update = Objective.create! valid_attributes
      put :update, params: {id: objective_to_update.to_param, objective: {objective_id: objective.id}}
      objective_to_update.reload
      expect(objective_to_update.name).not_to match("A")
    end

    it "redirects to edit update if invalid attributes" do
      objective_to_update = Objective.create! valid_attributes
      put :update, params: {id: objective_to_update.to_param, objective: {name: nil}}
      assert_template :edit
    end

    it "redirects to objectives after update objective" do
      objective_to_update = Objective.create! valid_attributes
      put :update, params: {id: objective_to_update.to_param, objective: {name: "Meta atualizada"}}
      # "/editobjective?objective_id=#{objective.id}"
      expect(response).to redirect_to(myplan_path)
    end

    it 'expects put update to fail if is not owner of activity' do
      expect(
          put :update, params: {id: objective_2.to_param, objective: {name: "Obj 123", plan_id: plan.id, sphere_id: sphere.id}}
      ).to redirect_to(root_path)
    end
  end

  context "DELETE #destroy" do
    it "destroy the requested objective" do
      objective_to_destroy = Objective.create! valid_attributes
      expect {
        delete :destroy, params: {id: objective_to_destroy.id}
      }.to change(Objective, :count).by(-1)
    end
    it "redirects to objectives after update objective" do
      objective_to_destroy = Objective.create! valid_attributes
      delete :destroy, params: {id: objective_to_destroy.to_param}
      expect(response).to redirect_to(myplan_path)
    end
    it "expects delete to fail if is not owner of objective" do
      expect {
        delete :destroy, params: {id: objective_2.id}
      }.to change(Objective, :count).by(0)
    end
  end
end


