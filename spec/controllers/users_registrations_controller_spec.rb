require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  let!(:user_admin) { User.create!(email: 'admin2@admin2.com', password: 'skdD.sk@#ffew2', name: 'admin2', role: 'admin') }
  let!(:user_default) { FactoryBot.create(:user) }

  let(:valid_attributes) { { email: 'test2@ltr.com', password: 'skdD.sk@#dffew2', name: 'test destroy' } }

  let(:valid_session) { {} }

  before :each do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  context 'GET #index' do
    it 'not return index whithout login' do
      get :index
      expect(response).to redirect_to(root_path)
    end
    it 'not return index with default_user' do
      sign_in user_default
      get :index
      expect(response).to redirect_to(root_path)
    end
    it 'return index success response with admin' do
      sign_in user_admin
      get :index
      expect(response).to be_successful
    end
  end

  context 'GET #new' do
    it 'assigns a new' do
      get :new, valid_session
      expect(response).to be_successful
    end
  end

  context 'DELETE #destroy' do
    it 'do not destroy the requested user' do
      sign_in user_default
      user_to_destroy = User.create! valid_attributes
      delete :destroy_another_user, params: { id: user_to_destroy.id }
      expect(response).to redirect_to(root_path)
    end

    it 'destroy the requested user' do
      sign_in user_admin
      user_to_destroy = User.create! valid_attributes
      expect {
        delete :destroy_another_user, params: { id: user_to_destroy.id }
      }.to change(User, :count).by(-1)
    end
  end
end
