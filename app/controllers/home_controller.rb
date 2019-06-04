class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @contact = Contact.new
    @disable_nav = true
    @disable_footer = true
  end
end