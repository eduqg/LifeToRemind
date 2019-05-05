require 'rails_helper'

RSpec.describe PlansController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:plan) { FactoryBot.create(:plan) }

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
end
