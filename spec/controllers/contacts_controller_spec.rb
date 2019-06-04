require 'rails_helper'

RSpec.describe ContactsController, type: :controller do
  let(:valid_attributes) {{name: "Carla", email: "carla@ltr.com", message: "Site muito bom!"}}

  let(:invalid_attributes) {{email: "carla@ltr.com", message: "Site muito bom!"}}

  let(:valid_session) { {} }

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
    it "creates a Contact" do
      expect {
        post :create, params: {contact: valid_attributes}
      }.to change(Contact, :count).by(1)

    end

    it "assigns a newly created contact as @contact" do
      post :create, params: {contact: valid_attributes}
      expect(assigns(:contact)).to be_a(Contact)
      expect(assigns(:contact)).to be_persisted
    end

    it "not create a Contact" do
      expect {
        post :create, params: {contact: invalid_attributes}
      }.to change(Contact, :count).by(0)
    end

    it "redirects to new contact if invalid attributes" do
      post :create, params: {contact: invalid_attributes}
      assert_template :new
      # Works too: expect(response).to render_template("new")
    end

    it "redirects to index after create contact" do
      post :create, params: {contact: valid_attributes}
      expect(response).to redirect_to(root_path)
    end
  end

  context "DELETE #destroy" do
    it "destroy the requested contact" do
      contact_to_destroy = Contact.create! valid_attributes
      expect {
        delete :destroy, params: {id: contact_to_destroy.id}
      }.to change(Contact, :count).by(-1)
    end
    it "redirects to contacts after update contact" do
      contact_to_update = Contact.create! valid_attributes
      delete :destroy, params: {id: contact_to_update.to_param}
      expect(response).to redirect_to(contacts_path)
    end
  end
end
