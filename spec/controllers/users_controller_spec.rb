require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  context "GET #index" do
    it "return a success response" do
      get :index
      expect(response).to be_success
    end
  end

  let(:user) { FactoryBot.create(:user) }
  context "GET #show" do
    it "returns a success response" do
      get :show, params: {id: user.to_param}
      expect(response).to be_success
    end
  end
end
