require 'rails_helper'

RSpec.describe GoalsController, type: :controller do
    let!(:goal) {FactoryBot.create(:goal)}
    let!(:objective) {Objective.find(goal.objective_id)}
    let!(:plan) {Plan.find(objective.plan_id)}
    let!(:user) {User.find(plan.user_id)}

    let!(:user_2) {User.create!(email: '22@22.com', password: 'skdD.sk@#ffew2', name: 'user 2')}
    let!(:plan_2) {Plan.create!(name:"2 Plan", user_id: user_2.id)}
    let!(:sphere_2) {Sphere.create!(name: "ReallyNormalName", user_id: user_2.id)}
    let!(:objective_2) {Objective.create!(name: "My Objective", plan_id: plan_2.id, sphere_id: sphere_2.id)}
    let!(:goal_2) {Goal.create!(name: "My goal", objective_id: objective_2.id )}

    let(:valid_attributes) { { name: "My goal", objective_id: objective.id } }

    let(:invalid_attributes) { { objective_id: objective.id } }

    let(:update_attributes) { { name: "Meta atualizada", objective_id: objective.id } }

    let(:valid_session) { {} }

    before :each do
      sign_in user
    end


    context "GET #index" do
      it "return index success response" do
        get :index
        expect(response).to redirect_to(root_path)
      end
    end

    context "GET #show" do
      it "returns show success response" do
        get :show, params: {id: goal.to_param}
        expect(response).to redirect_to(root_path)
      end
    end

    context "GET #new" do
      it "assigns a new" do
        get :new, valid_session
      end
    end

    context "GET #create" do
      it "creates an Goal" do
        expect {
          post :create, params: { goal: valid_attributes }
        }.to change(Goal, :count).by(1)

      end

      it "assigns a newly created goal as @goal" do
        post :create, params: { goal: valid_attributes }
        expect(assigns(:goal)).to be_a(Goal)
        expect(assigns(:goal)).to be_persisted
      end

      it "not create an goal" do
        expect {
          post :create, params: { goal: invalid_attributes }
        }.to change(Goal, :count).by(0)
      end

      it "redirects to new goal if invalid attributes" do
        post :create, params: { goal: invalid_attributes }
        assert_template :new
        # Works too: expect(response).to render_template("new")
      end

      it "redirects to index after create goal" do
        post :create, params: { goal: valid_attributes }
        expect(response).to redirect_to("/editobjective?objective_id=#{objective.id}")
      end
    end

    context "GET #update" do
      it "updates an goal" do
        goal_to_update = Goal.create! valid_attributes
        put :update, params: { id: goal_to_update.to_param, goal:  { name: "Meta atualizada", objective_id: objective.id}}
        goal_to_update.reload
        expect(goal_to_update.name).to match("Meta atualizada")
      end

      it "fails to update a goal" do
        goal_to_update = Goal.create! valid_attributes
        put :update, params: { id: goal_to_update.to_param, goal:  { objective_id: objective.id }}
        goal_to_update.reload
        expect(goal_to_update.name).not_to match("A")
      end

      it "redirects to edit update if invalid attributes" do
        goal_to_update = Goal.create! valid_attributes
        put :update, params: { id: goal_to_update.to_param, goal:  { name:nil, objective_id: objective.id}}
        assert_template :edit
      end

      it "redirects to editobjectives after update goal" do
        goal_to_update = Goal.create! valid_attributes
        put :update, params: { id: goal_to_update.to_param, goal:  { name: "Meta atualizada", objective_id: objective.id}}
        expect(response).to redirect_to("/editobjective?objective_id=#{objective.id}")
      end

      it 'expects put update to fail if is not owner of goal' do
        expect(
            put :update, params: {id: goal_2.to_param, goal: {name: "My goa2l", objective_id: objective.id}}
        ).to redirect_to(root_path)
      end
    end

    context "DELETE #destroy" do
      it "destroy the requested goal" do
        goal_to_destroy = Goal.create! valid_attributes
        expect {
          delete :destroy, params: { id: goal_to_destroy.id }
        }.to change(Goal, :count).by(-1)
      end
      it "redirects to editobjectives after update goal" do
        goal_to_destroy = Goal.create! valid_attributes
        delete :destroy, params: { id: goal_to_destroy.to_param }
        expect(response).to redirect_to("/editobjective?objective_id=#{objective.id}")
      end
      it "expects delete to fail if is not owner of goal" do
        expect {
          delete :destroy, params: {id: goal_2.id}
        }.to change(Goal, :count).by(0)
      end
    end

  end

