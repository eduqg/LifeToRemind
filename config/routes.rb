Rails.application.routes.draw do
  devise_for :users
  get "missions/update_selected_mission", to: "missions#update_selected_mission"
  resources :plans
  resources :missions, only: [:index, :new, :create, :destroy, :edit, :update]
  root to: "plans#index"

end
