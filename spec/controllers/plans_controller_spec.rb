require 'rails_helper'

RSpec.describe PlansController, type: :controller do
  let!(:plan) {FactoryBot.create(:plan)}
  let!(:user) {User.find(plan.user_id)}

  let!(:user_2) {User.create!(email: '22@22.com', password: 'skdD.sk@#ffew2', name: 'user 2')}
  let!(:plan_2) {Plan.create!(name: "2 Plan", user_id: user_2.id)}

  #let!(:valid_simple_json) {fixture_file_upload('./fixtures/valid_simple_file_test.json', 'application/json')}

  let(:valid_attributes) {{name: "Meu plano", user_id: user.id}}

  let(:invalid_attributes) {{name: "Me", user_id: user.id}}

  let(:update_attributes) {{name: "Plano atualizado", user_id: user.id}}

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

  context "GET #new" do
    it "assigns a new" do
      get :new, valid_session
    end
  end

  context "GET #create" do
    it "creates a Plan" do
      expect {
        post :create, params: {plan: valid_attributes}
      }.to change(Plan, :count).by(1)

    end

    it "assigns a newly created plan as @plan" do
      post :create, params: {plan: valid_attributes}
      expect(assigns(:plan)).to be_a(Plan)
      expect(assigns(:plan)).to be_persisted
    end

    it "not create a Plan" do
      expect {
        post :create, params: {plan: invalid_attributes}
      }.to change(Plan, :count).by(0)
    end

    it "redirects to new plan if invalid attributes" do
      post :create, params: {plan: invalid_attributes}
      assert_template :new
      # Works too: expect(response).to render_template("new")
    end

    it "redirects to index after create plan" do
      post :create, params: {plan: valid_attributes}
      expect(response).to redirect_to(plans_swotedit_path)
    end
  end

  context "GET #update" do
    it "updates a plan" do
      plan_to_update = Plan.create! valid_attributes
      put :update, params: {id: plan_to_update.to_param, plan: {name: "Plano atualizado"}}
      plan_to_update.reload
      expect(plan_to_update.name).to match("Plano atualizado")
    end

    it "fails to update a plan" do
      plan_to_update = Plan.create! valid_attributes
      put :update, params: {id: plan_to_update.to_param, plan: {name: "A"}}
      plan_to_update.reload
      expect(plan_to_update.name).not_to match("A")
    end

    it "redirects to edit update if invalid attributes" do
      plan_to_update = Plan.create! valid_attributes
      put :update, params: {id: plan_to_update.to_param, plan: {name: "Pla"}}
      assert_template :edit
      # Works too: expect(response).to render_template("new")
    end

    it "redirects to index after update plan" do
      plan_to_update = Plan.create! valid_attributes
      put :update, params: {id: plan_to_update.to_param, plan: {name: "Plano atualizado"}}
      expect(response).to redirect_to(plans_path)
    end

    it 'expects put update to fail if is not owner of goal' do
      expect(
          put :update, params: {id: plan_2.to_param, plan: {name: "plan 123", user_id: user.id}}
      ).to redirect_to(root_path)
    end
  end

  context "DELETE #destroy" do
    it "destroy the requested plan" do
      plan_to_destroy = Plan.create! valid_attributes
      expect {
        delete :destroy, params: {id: plan_to_destroy.id}
      }.to change(Plan, :count).by(-1)
    end
    it "redirects to index after update plan" do
      plan_to_update = Plan.create! valid_attributes
      delete :destroy, params: {id: plan_to_update.to_param}
      expect(response).to redirect_to(plans_path)
    end
  end
  context "PUT #update_selected_plan" do
    it "should update selected plan on user" do
      user.selected_plan = nil
      user.save
      put :update_selected_plan, params: {plan_id: plan.id}
      user.reload
      expect(user.selected_plan).to eq(plan.id)
    end
  end
  it "expects delete to fail if is not owner of plan" do
    expect {
      delete :destroy, params: {id: plan_2.id}
    }.to change(Plan, :count).by(0)
  end
end


