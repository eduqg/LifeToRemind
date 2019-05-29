require 'rails_helper'

RSpec.describe CsfsController, type: :controller do
  let!(:csf) {FactoryBot.create(:csf)}
  let!(:user) {User.find(csf.user_id)}
  let!(:plan) {Plan.create!(name: "My incredible plan", user_id: user.id)}

  let(:valid_attributes) {{what_makes_me_unique: "where", best_attributes: "how", essential_atributes: "sdlkmsdkfm", health_factors:"slkmsdfk", user_id: user.id}}

  let(:invalid_attributes) {{best_attributes: "how", essential_atributes: "sdlkmsdkfm", health_factors:"slkmsdfk", user_id: user.id}}

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
      get :edit, params: {use_route: "csfs/", id: csf.id}
      expect(response.status).to eq(200)
    end
  end

  context "GET #create" do
    it "creates an Csf" do
      expect {
        post :create, params: {csf: valid_attributes}
      }.to change(Csf, :count).by(1)

    end

    it "assigns a newly created csf as @csf" do
      post :create, params: {csf: valid_attributes}
      expect(assigns(:csf)).to be_a(Csf)
      expect(assigns(:csf)).to be_persisted
    end

    it "not create an csf" do
      expect {
        post :create, params: {csf: invalid_attributes}
      }.to change(Csf, :count).by(0)
    end

    it "redirects to new csf if invalid attributes" do
      post :create, params: {csf: invalid_attributes}
      assert_template :new
      # Works too: expect(response).to render_template("new")
    end

    it "redirects to index after create csf" do
      post :create, params: {csf: valid_attributes}
      expect(response).to redirect_to(new_value_path)
    end
  end

  context "GET #update" do
    it "updates an csf" do
      csf_to_update = Csf.create! valid_attributes
      put :update, params: {id: csf_to_update.to_param, csf: {what_makes_me_unique: "Com forca de vontade", user_id: user.id}}
      csf_to_update.reload
      expect(csf_to_update.what_makes_me_unique).to match("Com forca de vontade")
    end

    it "fails to update a csf" do
      csf_to_update = Csf.create! valid_attributes
      put :update, params: {id: csf_to_update.to_param, csf: {what_makes_me_unique: nil, user_id: user.id}}
      csf_to_update.reload
      expect(csf_to_update.what_makes_me_unique).not_to match("A")
    end

    it "redirects to edit update if invalid attributes" do
      csf_to_update = Csf.create! valid_attributes
      put :update, params: {id: csf_to_update.to_param, csf: {what_makes_me_unique: nil}}
      assert_template :edit
    end

    it "redirects to csfs after update csf" do
      csf_to_update = Csf.create! valid_attributes
      put :update, params: {id: csf_to_update.to_param, csf: {what_makes_me_unique: "Como completar missao atualizado", }}
      expect(response).to redirect_to(csfs_path)
    end
  end

  context "DELETE #destroy" do
    it "destroy the requested csf" do
      csf_to_destroy = Csf.create! valid_attributes
      expect {
        delete :destroy, params: {id: csf_to_destroy.id}
      }.to change(Csf, :count).by(-1)
    end
    it "redirects to csfs after update csf" do
      csf_to_destroy = Csf.create! valid_attributes
      delete :destroy, params: {id: csf_to_destroy.to_param}
      expect(response).to redirect_to(csfs_path)
    end
    it "set current_csf to nil after destroy" do
      csf_to_destroy = Csf.create! valid_attributes
      plan.selected_csf = csf_to_destroy.id
      plan.save
      delete :destroy, params: {id: csf_to_destroy.to_param}
      plan.reload
      expect(plan.selected_csf).to eq(nil)
    end
  end

  context "PUT #update_selected_csf" do
    it "should not update without selected plan" do
      user.selected_plan = nil
      user.save
      put :update_selected_csf, params: {csf_id: csf.id}
      plan.reload
      expect(flash[:info]).to match(/Fator crítico de sucesso selecionado não pode ser atualizado.*/)
    end

    it "should update selected csf on plan" do
      plan.selected_csf = nil
      plan.save
      put :update_selected_csf, params: {csf_id: csf.id}
      plan.reload
      expect(plan.selected_csf).to eq(csf.id)
    end
  end
end
