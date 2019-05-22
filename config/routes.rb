Rails.application.routes.draw do
  resources :activities do
    collection do
      put :checked
    end
  end
  resources :goals
  resources :spheres
  resources :objectives

  get "editobjectives", to: "objectives#editobjectives"
  get "inicio", to:"plans#inicio"
  get "plans/swotedit", to: "plans#swotedit"
  get "swot", to:"plans#swot"
  get "myplan", to: "plans#myplan"
  get "plans/update_selected_plan", to: "plans#update_selected_plan"
  put "missions/update_selected_mission", to: "missions#update_selected_mission"

  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations" }
  resources :swotparts
  resources :plans
  resources :missions, only: [:index, :new, :create, :destroy, :edit, :update]
  root to: "home#index"
end
