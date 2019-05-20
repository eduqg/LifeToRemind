require 'rails_helper'

RSpec.describe PlansController, type: :controller do
  let!(:plan) {FactoryBot.create(:plan)}
  let!(:user) {User.find(plan.user_id)}

  let(:valid_attributes) { { name: "Meu plano", user_id: user.id } }

  let(:invalid_attributes) { { name: "Me", user_id: user.id } }

  let(:update_attributes) { { name: "Plano atualizado", user_id: user.id } }

  let(:valid_session) { {} }

  before :each do
    sign_in user
  end

  context "GET #index" do
    it "return index success response" do
      get :index
      expect(response).to be_success
    end
  end

  context "GET #show" do
    it "returns show success response" do
      get :show, params: {id: plan.to_param}
      expect(response).to be_success
    end
  end

  context "GET #new" do
    it "assigns a new" do
      get :new, valid_session
    end
  end

  context "GET #create" do
    it "creates a Plan" do
      expect {
        post :create, params: { plan: valid_attributes }
      }.to change(Plan, :count).by(1)

    end

    it "assigns a newly created plan as @plan" do
      post :create, params: { plan: valid_attributes }
      expect(assigns(:plan)).to be_a(Plan)
      expect(assigns(:plan)).to be_persisted
    end
    it "not create a Plan" do
      expect {
        post :create, params: { plan: invalid_attributes }
      }.to change(Plan, :count).by(0)
    end


  end

  context "GET #update" do
    it "updates a plan" do
      plan_to_update = Plan.create! valid_attributes
      put :update, params: { id: plan_to_update.to_param, plan:  { name: "Plano atualizado"}}
      plan_to_update.reload

      expect(plan_to_update.name).to match("Plano atualizado")
    end

    it "fails to update a plan" do
      plan_to_update = Plan.create! valid_attributes
      put :update, params: { id: plan_to_update.to_param, plan:  { name: "A"}}
      plan_to_update.reload

      expect(plan_to_update.name).not_to match("A")
    end
  end

end
