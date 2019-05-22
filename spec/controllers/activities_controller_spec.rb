require 'rails_helper'

RSpec.describe ActivitiesController, type: :controller do
  let!(:activity) {FactoryBot.create(:activity)}
  let!(:goal) {Goal.find(activity.goal_id)}
  let!(:objective) {Objective.find(goal.objective_id)}
  let!(:plan) {Plan.find(objective.plan_id)}
  let!(:user) {User.find(plan.user_id)}

  let(:valid_attributes) { { title: "My activity", goal_id: goal.id } }

  let(:invalid_attributes) { { goal_id: goal.id } }

  let(:update_attributes) { { name: "Atividade atualizada", goal_id: goal.id } }

  let(:valid_session) { {} }

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
      get :show, params: {id: activity.to_param}
      expect(response).to be_successful
    end
  end

  context "GET #new" do
    it "assigns a new" do
      get :new, valid_session
    end
  end

  context "GET #create" do
    it "creates an Activity" do
      expect {
        post :create, params: { activity: valid_attributes }
      }.to change(Activity, :count).by(1)

    end

    it "assigns a newly created activity as @activity" do
      post :create, params: { activity: valid_attributes }
      expect(assigns(:activity)).to be_a(Activity)
      expect(assigns(:activity)).to be_persisted
    end

    it "not create an activity" do
      expect {
        post :create, params: { activity: invalid_attributes }
      }.to change(Activity, :count).by(0)
    end

    it "redirects to new activity if invalid attributes" do
      post :create, params: { activity: invalid_attributes }
      assert_template :new
      # Works too: expect(response).to render_template("new")
    end

    it "redirects to index after create activity" do
      post :create, params: { activity: valid_attributes }
      expect(response).to redirect_to("/activities?goal_id=#{goal.id}")
    end
  end

  context "GET #update" do
    it "updates an activity" do
      activity_to_update = Activity.create! valid_attributes
      put :update, params: { id: activity_to_update.to_param, activity:  { title: "Atividade atualizada"}}
      activity_to_update.reload
      expect(activity_to_update.title).to match("Atividade atualizada")
    end

    it "fails to update a activity" do
      activity_to_update = Activity.create! valid_attributes
      put :update, params: { id: activity_to_update.to_param, activity:  { checked: true}}
      activity_to_update.reload
      expect(activity_to_update.title).not_to match("A")
    end

    it "redirects to edit update if invalid attributes" do
      activity_to_update = Activity.create! valid_attributes
      put :update, params: { id: activity_to_update.to_param, activity:  { title: "Pla"}}
      expect(response).to redirect_to("http://test.host/activities?goal_id=#{goal.id}")
    end

    it "redirects to index after update activity" do
      activity_to_update = Activity.create! valid_attributes
      put :update, params: { id: activity_to_update.to_param, activity:  { title: "Atividade atualizada"}}
      expect(response).to redirect_to("/activities?goal_id=#{goal.id}")
    end
  end

  context "DELETE #destroy" do
    it "destroy the requested activity" do
      activity_to_destroy = Activity.create! valid_attributes
      expect {
        delete :destroy, params: { id: activity_to_destroy.id }
      }.to change(Activity, :count).by(-1)
    end
    it "redirects to index after update activity" do
      activity_to_destroy = Activity.create! valid_attributes
      delete :destroy, params: { id: activity_to_destroy.to_param }
      expect(response).to redirect_to(editobjectives_path)
    end
  end

end
