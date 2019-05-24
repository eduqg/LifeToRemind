require 'rails_helper'

RSpec.describe VisionsController, type: :controller do
  let!(:vision) {FactoryBot.create(:vision)}
  let!(:user) {User.find(vision.user_id)}
  let!(:plan) {Plan.create!(name:"My incredible plan", user_id: user.id)}

  let(:valid_attributes) {{ where_im_going:"where1", where_arrive:"where", how_complete_mission: "how", user_id: user.id}}

  let(:invalid_attributes) {{ where_arrive:"where", how_complete_mission: "how", user_id: user.id}}

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
      get :edit, params: { use_route: "visions/", id: vision.id }
      expect(response.status).to eq(200)
    end
  end

  context "GET #create" do
    it "creates an Vision" do
      expect {
        post :create, params: {vision: valid_attributes}
      }.to change(Vision, :count).by(1)

    end

    it "assigns a newly created vision as @vision" do
      post :create, params: {vision: valid_attributes}
      expect(assigns(:vision)).to be_a(Vision)
      expect(assigns(:vision)).to be_persisted
    end

    it "not create an vision" do
      expect {
        post :create, params: {vision: invalid_attributes}
      }.to change(Vision, :count).by(0)
    end

    it "redirects to new vision if invalid attributes" do
      post :create, params: {vision: invalid_attributes}
      assert_template :new
      # Works too: expect(response).to render_template("new")
    end

    it "redirects to index after create vision" do
      post :create, params: {vision: valid_attributes}
      expect(response).to redirect_to(visions_path)
    end
  end

  context "GET #update" do
    it "updates an vision" do
      vision_to_update = Vision.create! valid_attributes
      put :update, params: {id: vision_to_update.to_param, vision: {how_complete_mission: "Com forca de vontade", user_id: user.id}}
      vision_to_update.reload
      expect(vision_to_update.how_complete_mission).to match("Com forca de vontade")
    end

    it "fails to update a vision" do
      vision_to_update = Vision.create! valid_attributes
      put :update, params: {id: vision_to_update.to_param, vision: {how_complete_mission: nil, user_id: user.id}}
      vision_to_update.reload
      expect(vision_to_update.how_complete_mission).not_to match("A")
    end

    it "redirects to edit update if invalid attributes" do
      vision_to_update = Vision.create! valid_attributes
      put :update, params: {id: vision_to_update.to_param, vision: {how_complete_mission: nil}}
      assert_template :edit
    end

    it "redirects to visions after update vision" do
      vision_to_update = Vision.create! valid_attributes
      put :update, params: {id: vision_to_update.to_param, vision: {how_complete_mission: "Como completar missao atualizado",}}
      expect(response).to redirect_to(visions_path)
    end
  end

  context "DELETE #destroy" do
    it "destroy the requested vision" do
      vision_to_destroy = Vision.create! valid_attributes
      expect {
        delete :destroy, params: {id: vision_to_destroy.id}
      }.to change(Vision, :count).by(-1)
    end
    it "redirects to visions after update vision" do
      vision_to_destroy = Vision.create! valid_attributes
      delete :destroy, params: {id: vision_to_destroy.to_param}
      expect(response).to redirect_to(visions_path)
    end
    it "set current_vision to nil after destroy" do
      vision_to_destroy = Vision.create! valid_attributes
      plan.selected_vision = vision_to_destroy.id
      plan.save
      delete :destroy, params: {id: vision_to_destroy.to_param}
      plan.reload
      expect(plan.selected_vision).to eq(nil)
    end
  end

  context "PUT #update_selected_vision" do
    it "should not update without selected plan" do
      user.selected_plan = nil
      user.save
      put :update_selected_vision, params: {vision_id: vision.id}
      plan.reload
      expect(flash[:info]).to match(/Visão selecionada não pode ser atualizada.*/)
    end

    it "should update selected vision on plan" do
      plan.selected_vision = nil
      plan.save
      put :update_selected_vision, params: {vision_id: vision.id}
      plan.reload
      expect(plan.selected_vision).to eq(vision.id)
    end
  end
end
