require 'rails_helper'

RSpec.describe ContactsController, type: :controller do
  let(:valid_attributes) {{name: 'Carla', email: 'carla@ltr.com', message: 'Site muito bom!'}}

  let(:invalid_attributes) {{email: 'carla@ltr.com', message: 'Site muito bom!'}}

  let(:valid_session) { {} }

  let!(:user_admin) {User.create!(email: 'admin2@admin2.com', password: 'skdD.sk@#ffew2', name: 'admin2', role: 'admin')}
  let!(:user_default) {FactoryBot.create(:user)}

  context 'GET #index' do
    it 'not return index whithout login' do
      get :index
      expect(response).not_to be_successful
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
    end
  end

  context 'GET #create' do
    it 'creates a Contact' do
      expect {
        post :create, params: {contact: valid_attributes}
      }.to change(Contact, :count).by(1)

    end

    it 'assigns a newly created contact as @contact' do
      post :create, params: {contact: valid_attributes}
      expect(assigns(:contact)).to be_a(Contact)
      expect(assigns(:contact)).to be_persisted
    end

    it 'not create a Contact' do
      expect {
        post :create, params: {contact: invalid_attributes}
      }.to change(Contact, :count).by(0)
    end

    it 'redirects to new contact if invalid attributes' do
      post :create, params: {contact: invalid_attributes}
      assert_template :new
      # Works too: expect(response).to render_template('new')
    end

    it 'redirects to index after create contact' do
      post :create, params: {contact: valid_attributes}
      expect(response).to redirect_to(root_path)
    end
  end

  context 'DELETE #destroy' do
    it 'destroy the requested contact' do
      sign_in user_admin
      contact_to_destroy = Contact.create! valid_attributes
      expect {
        delete :destroy, params: {id: contact_to_destroy.id}
      }.to change(Contact, :count).by(-1)
    end
  end
end
