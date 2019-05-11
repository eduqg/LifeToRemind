Rails.application.routes.draw do
  resources :goals
  resources :spheres
  resources :objectives

  get "editobjectives", to: "objectives#editobjectives"
  get "inicio", to:"plans#inicio"
  get "plans/swotedit", to: "plans#swotedit"
  post "swotparts/create_swot_swotpart", to: "swotparts#create_swot_swotpart"
  get "swot", to:"plans#swot"
  get "myplan", to: "plans#myplan"
  get "plans/update_selected_plan", to: "plans#update_selected_plan"
  get "missions/update_selected_mission", to: "missions#update_selected_mission"

  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations" }
  resources :swotparts
  resources :plans
  resources :missions, only: [:index, :new, :create, :destroy, :edit, :update]
  root to: "home#index"
end
