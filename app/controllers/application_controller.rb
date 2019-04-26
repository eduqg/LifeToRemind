class ApplicationController < ActionController::Base
  # Forces to be logged in
  before_action :authenticate_user!
end
