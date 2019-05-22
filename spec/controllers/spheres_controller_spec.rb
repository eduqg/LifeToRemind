require 'rails_helper'

RSpec.describe SpheresController, type: :controller do
  let!(:sphere) {FactoryBot.create(:sphere)}
  let!(:user) {User.find(sphere.user_id)}

  let(:valid_attributes) {{name: "ReallyNormalName", user_id: user.id}}

  let(:invalid_attributes) {{name: "Re", user_id: user.id}}

  let(:update_attributes) {{name: "Âmbito atualizado", user_id: user.id}}

  let(:valid_session) {{}}

  before :each do
    sign_in user
  end


  context "GET #index" do
    it "return index success response" do
      get :index
      expect(response).to be_successful
    end
  end

  context "GET #show" do
    it "returns show success response" do
      get :show, params: {id: sphere.to_param}
      expect(response).to be_successful
    end
  end

  context "GET #new" do
    it "assigns a new" do
      get :new, valid_session
    end
  end

  context "GET #create" do
    it "creates an Sphere" do
      expect {
        post :create, params: {sphere: valid_attributes}
      }.to change(Sphere, :count).by(1)

    end

    it "assigns a newly created sphere as @sphere" do
      post :create, params: {sphere: valid_attributes}
      expect(assigns(:sphere)).to be_a(Sphere)
      expect(assigns(:sphere)).to be_persisted
    end

    it "not create an sphere" do
      expect {
        post :create, params: {sphere: invalid_attributes}
      }.to change(Sphere, :count).by(0)
    end

    it "redirects to new sphere if invalid attributes" do
      post :create, params: {sphere: invalid_attributes}
      assert_template :new
      # Works too: expect(response).to render_template("new")
    end

    it "redirects to index after create sphere" do
      post :create, params: {sphere: valid_attributes}
      expect(response).to redirect_to(new_objective_path)
    end
  end

  context "GET #update" do
    it "updates an sphere" do
      sphere_to_update = Sphere.create! valid_attributes
      put :update, params: {id: sphere_to_update.to_param, sphere: {name: "Âmbito atualizado", sphere_id: sphere.id}}
      sphere_to_update.reload
      expect(sphere_to_update.name).to match("Âmbito atualizado")
    end

    it "fails to update a sphere" do
      sphere_to_update = Sphere.create! valid_attributes
      put :update, params: {id: sphere_to_update.to_param, sphere: {sphere_id: sphere.id}}
      sphere_to_update.reload
      expect(sphere_to_update.name).not_to match("A")
    end

    it "redirects to edit update if invalid attributes" do
      sphere_to_update = Sphere.create! valid_attributes
      put :update, params: {id: sphere_to_update.to_param, sphere: {name: nil}}
      assert_template :edit
    end

    it "redirects to spheres after update sphere" do
      sphere_to_update = Sphere.create! valid_attributes
      put :update, params: {id: sphere_to_update.to_param, sphere: {name: "Âmbito atualizado"}}
      expect(response).to redirect_to(new_objective_path)
    end
  end

  context "DELETE #destroy" do
    it "destroy the requested sphere" do
      sphere_to_destroy = Sphere.create! valid_attributes
      expect {
        delete :destroy, params: {id: sphere_to_destroy.id}
      }.to change(Sphere, :count).by(-1)
    end
    it "redirects to spheres after update sphere" do
      sphere_to_destroy = Sphere.create! valid_attributes
      delete :destroy, params: {id: sphere_to_destroy.to_param}
      expect(response).to redirect_to(new_objective_path)
    end
  end


end
