class MissionsController < ApplicationController
  def index
    @missions = Mission.all
  end
end
