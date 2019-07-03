require 'rails_helper'

RSpec.describe ValuesController, type: :controller do
  let!(:value) {FactoryBot.create(:value)}
  let!(:plan) {Plan.find(value.plan_id)}
  let!(:user) {User.find(plan.user_id)}

  let!(:user_2) {User.create!(email: 'user2@user2.com', password: 'skdD.sk@#ffe2w2', name: 'user2')}
  let!(:plan_2) {Plan.create!(name:"User 2 Plan", user_id: user_2.id)}
  let!(:value_2) {Value.create!(name: "Really Normal value", plan_id: plan_2.id)}

  let(:valid_attributes) {{name: "ReallyNormalName", plan_id: plan.id}}

  let(:invalid_attributes) {{plan_id: plan.id}}

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
    it "creates an Value" do
      expect {
        post :create, params: {value: valid_attributes}
      }.to change(Value, :count).by(1)

    end

    it "assigns a newly created value as @value" do
      post :create, params: {value: valid_attributes}
      expect(assigns(:value)).to be_a(Value)
      expect(assigns(:value)).to be_persisted
    end

    it "not create an value" do
      expect {
        post :create, params: {value: invalid_attributes}
      }.to change(Value, :count).by(0)
    end

    it "redirects to new value if invalid attributes" do
      post :create, params: {value: invalid_attributes}
      assert_template :new
      # Works too: expect(response).to render_template("new")
    end

    it "redirects to index after create value" do
      post :create, params: {value: valid_attributes}
      expect(response).to redirect_to(new_value_path)
    end
  end

  context "GET #update" do
    it "updates an value" do
      value_to_update = Value.create! valid_attributes
      put :update, params: {id: value_to_update.to_param, value: {name: "Valor atualizado", value_id: value.id}}
      value_to_update.reload
      expect(value_to_update.name).to match("Valor atualizado")
    end

    it "fails to update a value" do
      value_to_update = Value.create! valid_attributes
      put :update, params: {id: value_to_update.to_param, value: {name: nil, value_id: value.id}}
      value_to_update.reload
      expect(value_to_update.name).not_to match("A")
    end

    it "redirects to edit update if invalid attributes" do
      value_to_update = Value.create! valid_attributes
      put :update, params: {id: value_to_update.to_param, value: {name: nil}}
      assert_template :edit
    end

    it "redirects to values after update value" do
      value_to_update = Value.create! valid_attributes
      put :update, params: {id: value_to_update.to_param, value: {name: "Valor atualizado"}}
      expect(response).to redirect_to(myplan_path)
    end

    it 'expects put update to fail if is not owner of value' do
      expect(
          put :update, params: {id: value_2.to_param, value: {name: "Valor atualizado 2", value_id: value_2.id, plan_id_2: plan.id}}
      ).to redirect_to(root_path)
      # assert_equal 'Você não pode atualizar esse valor', flash[:danger]
      # shows 'Você não pode atualizar esse valor'
    end
  end

  context "DELETE #destroy" do
    it "destroy the requested value" do
      value_to_destroy = Value.create! valid_attributes
      expect {
        delete :destroy, params: {id: value_to_destroy.id}
      }.to change(Value, :count).by(-1)
    end
    it "redirects to values after update value" do
      value_to_destroy = Value.create! valid_attributes
      delete :destroy, params: {id: value_to_destroy.to_param}
      expect(response).to redirect_to(values_path)
    end
    it "expects delete to fail if is not owner of value" do
      expect {
        delete :destroy, params: { id: value_2.id }
      }.to change(Value, :count).by(0)
    end
  end
end
