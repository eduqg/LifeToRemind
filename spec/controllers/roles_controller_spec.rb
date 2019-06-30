require 'rails_helper'

RSpec.describe RolesController, type: :controller do
  let!(:role) {FactoryBot.create(:role)}
  let!(:plan) {Plan.find(role.plan_id)}
  let!(:user) {User.find(plan.user_id)}

  let!(:user_2) {User.create!(email: 'user2@user2.com', password: 'skdD.sk@#ffe2w2', name: 'user2')}
  let!(:plan_2) {Plan.create!(name:"User 2 Plan", user_id: user_2.id)}
  let!(:role_2) {Role.create!(name: "Irmão", description: "Ser um irmão melhor", plan_id: plan_2.id)}
  let!(:role_3) {Role.create!(name: "Irmão 2", description: "Ser um irmão melhor", plan_id: plan_2.id)}

  let(:valid_attributes) {{name: "Irmão", description: "Ser um irmão melhor", plan_id: plan.id}}

  let(:invalid_attributes) {{name: "Irmão", plan_id: plan.id}}

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
    end
  end

  context "GET #create" do
    it "creates an Role" do
      expect {
        post :create, params: {role: valid_attributes}
      }.to change(Role, :count).by(1)

    end

    it "assigns a newly created role as @role" do
      post :create, params: {role: valid_attributes}
      expect(assigns(:role)).to be_a(Role)
      expect(assigns(:role)).to be_persisted
    end

    it "not create an role" do
      expect {
        post :create, params: {role: invalid_attributes}
      }.to change(Role, :count).by(0)
    end

    it "redirects to new role if invalid attributes" do
      post :create, params: {role: invalid_attributes}
      assert_template :new
      # Works too: expect(response).to render_template("new")
    end

    it "redirects to index after create role" do
      post :create, params: {role: valid_attributes}
      expect(response).to redirect_to(new_role_path)
    end
  end

  context "GET #update" do
    it "updates an role" do
      role_to_update = Role.create! valid_attributes
      put :update, params: {id: role_to_update.to_param, role: {name: "Valor atualizado", role_id: role.id}}
      role_to_update.reload
      expect(role_to_update.name).to match("Valor atualizado")
    end

    it "fails to update a role" do
      role_to_update = Role.create! valid_attributes
      put :update, params: {id: role_to_update.to_param, role: {name: nil, role_id: role.id}}
      role_to_update.reload
      expect(role_to_update.name).not_to match("A")
    end

    it "redirects to edit update if invalid attributes" do
      role_to_update = Role.create! valid_attributes
      put :update, params: {id: role_to_update.to_param, role: {name: nil}}
      assert_template :edit
    end

    it "redirects to roles after update role" do
      role_to_update = Role.create! valid_attributes
      put :update, params: {id: role_to_update.to_param, role: {name: "Valor atualizado"}}
      expect(response).to redirect_to(myplan_path)
    end

    it 'expects put update to fail if is not owner of role' do
      expect(
          put :update, params: {id: role_2.to_param, value: {title: "Role 123", plan_id: role.plan_id}}
      ).to redirect_to(root_path)
    end
  end

  context "DELETE #destroy" do
    it "destroy the requested role" do
      role_to_destroy = Role.create! valid_attributes
      expect {
        delete :destroy, params: {id: role_to_destroy.id}
      }.to change(Role, :count).by(-1)
    end
    it "redirects to roles after update role" do
      role_to_destroy = Role.create! valid_attributes
      delete :destroy, params: {id: role_to_destroy.to_param}
      expect(response).to redirect_to(myplan_path)
    end
    it "expects delete to fail if is not owner of role" do
      expect {
        delete :destroy, params: { id: role_2.id }
      }.to change(Role, :count).by(0)
    end
  end

end
