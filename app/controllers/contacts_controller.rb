class ContactsController < ApplicationController
  load_and_authorize_resource
  skip_before_action :authenticate_user!, only: [:new, :create]
  before_action :set_contact, only: [:destroy]

  # GET /contacts
  # GET /contacts.json
  def index
    @contacts = Contact.all
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)

    respond_to do |format|
      if @contact.save
        format.html {redirect_to root_path, notice: "Mensagem enviada com sucesso"}
      else
        format.html {render :new}
        format.json {render json: @contact.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact.destroy
    respond_to do |format|
      format.html {redirect_to contacts_path, notice: "Mensagem exluída"}
      format.json {head :no_content}
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_contact
    @contact = Contact.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end
end
