require 'rails_helper'

RSpec.describe SwotpartsController, type: :controller do
  let!(:swotpart) {FactoryBot.create(:swotpart)}
  let!(:plan) {Plan.find(swotpart.plan_id)}
  let!(:user) {User.find(plan.user_id)}

  let!(:user_2) {User.create!(email: 'user2@user2.com', password: 'skdD.sk@#ffe2w2', name: 'user2')}
  let!(:plan_2) {Plan.create!(name:"User 2 Plan", user_id: user_2.id)}
  let!(:swotpart_2) {Swotpart.create!(name: "Força do User 2", partname: "strength", plan_id: plan_2.id)}

  let!(:user_admin) {User.create!(email: 'admin2@admin2.com', password: 'skdD.sk@#ffew2', name: 'admin2', role: 'admin')}
  let!(:plan_admin) {Plan.create!(name:"Admin Plan", user_id: user_admin.id)}

  let(:valid_attributes) {{name: "My Swotpart", partname: "opportunity", plan_id: plan.id}}

  let(:invalid_attributes) {{partname: "strength", plan_id: plan.id}}

  let(:valid_session) {{}}

  before :each do
    sign_in user
    user.selected_plan = plan.id
    user.save
  end

  context "GET #index" do
    it "return root response" do
      get :index
      expect(response).to redirect_to(root_path)
    end
    it "return index success response" do
      sign_out user
      sign_in user_admin
      user_admin.selected_plan = plan_admin.id
      user_admin.save
      get :index
      expect(response).to be_successful
    end
  end

  context "GET #show" do
    it "returns root response" do
      get :show, params: { id: swotpart.id }
      expect(response).to redirect_to(root_path)
    end
    it "returns show success response" do
      sign_out user
      sign_in user_admin
      user_admin.selected_plan = plan_admin.id
      user_admin.save
      get :show, params: { id: swotpart.id }
      expect(response).to be_successful
    end
  end

  context "GET #new" do
    it "assigns a new" do
      get :new, valid_session
    end
  end

  context "GET #create" do
    it "creates an Swotpart" do
      expect {
        post :create, params: {partname: "strength", name:"aksdasd" }, as: :json
      }.to change(Swotpart, :count).by(1)

    end

    it "assigns a newly created swotpart as @swotpart" do
      post :create, params: {partname: "strength", name:"aksdasd" }, as: :json
      expect(assigns(:swotpart)).to be_a(Swotpart)
      expect(assigns(:swotpart)).to be_persisted
    end

    it "not create an swotpart" do
      expect {
        post :create, params: {swotpart: invalid_attributes}
      }.to change(Swotpart, :count).by(0)
    end

    it "redirects to new swotpart if invalid attributes" do
      post :create, params: {swotpart: invalid_attributes}
      expect( subject.request.flash[:info] ).to_not be_nil
      expect(response).to redirect_to(plans_swotedit_path)
      # Works too: expect(response).to render_template("new")
    end

    it "redirects to index after create swotpart" do
      post :create, params: {swotpart: valid_attributes}
      expect(response).to redirect_to(plans_swotedit_path)
    end
  end

  context "GET #update" do
    it "updates an swotpart" do
      swotpart_to_update = Swotpart.create! valid_attributes
      put :update, params: {id: swotpart_to_update.to_param, swotpart: {name: "Swotpart atualizada", plan_id: plan.id}}
      swotpart_to_update.reload
      expect(swotpart_to_update.name).to match("Swotpart atualizada")
    end

    it "fails to update a swotpart" do
      swotpart_to_update = Swotpart.create! valid_attributes
      put :update, params: {id: swotpart_to_update.to_param, swotpart: {partname: "strength", plan_id: plan.id}}
      swotpart_to_update.reload
      expect(swotpart_to_update.name).not_to match("A")
    end

    it "redirects to edit update if invalid attributes" do
      swotpart_to_update = Swotpart.create! valid_attributes
      put :update, params: {id: swotpart_to_update.to_param, swotpart: {name: nil}}
      assert_template :edit
    end

    it "redirects to swotparts after update swotpart" do
      swotpart_to_update = Swotpart.create! valid_attributes
      put :update, params: {id: swotpart_to_update.to_param, swotpart: {partname: "weak",name: "Swotpart atualizada"}}
      expect(response).to redirect_to(plans_swotedit_path)
    end

    it 'expects put update to fail if is not owner of swotpart' do
      expect(
          put :update, params: {id: swotpart_2.to_param, value: {name: "Activity 123", plan_id: plan.id}}
      ).to redirect_to(root_path)
    end
  end

  context "DELETE #destroy" do
    it "destroy the requested swotpart" do
      swotpart_to_destroy = Swotpart.create! valid_attributes
      expect {
        delete :destroy, params: {id: swotpart_to_destroy.id}
      }.to change(Swotpart, :count).by(-1)
    end
    it "redirects to swotparts after update swotpart" do
      swotpart_to_destroy = Swotpart.create! valid_attributes
      delete :destroy, params: {id: swotpart_to_destroy.to_param}
      expect(response).to redirect_to(plans_swotedit_path)
    end
    it "expects delete to fail if is not owner of swotpart" do
      expect {
        delete :destroy, params: { id: swotpart_2.id }
      }.to change(Swotpart, :count).by(0)
    end
  end
end
