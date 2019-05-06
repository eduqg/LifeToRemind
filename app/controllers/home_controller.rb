class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @disable_nav = true
    @disable_footer = true
  end
end