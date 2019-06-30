class ApplicationController < ActionController::Base
  # Forces to be logged in
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  def current_plan
    return unless current_user[:selected_plan]
    @current_plan ||= Plan.find(id = current_user[:selected_plan])
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_url, :alert => exception.message
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :selected_plan, :email, :password, :remember_me])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :selected_plan, :email, :password, :remember_me])
  end
end
