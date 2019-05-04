Rails.application.routes.draw do
  post "strengths/create_swot_strength", to: "strengths#create_swot_strength"
  get "swot", to:"plans#swot"
  get "myplan", to: "plans#myplan"
  get "plans/update_selected_plan", to: "plans#update_selected_plan"
  get "missions/update_selected_mission", to: "missions#update_selected_mission"

  devise_for :users
  resources :strengths
  resources :plans
  resources :missions, only: [:index, :new, :create, :destroy, :edit, :update]
  root to: "plans#index"
end
