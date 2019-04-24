Rails.application.routes.draw do
  get "plans/update_selected_mission", to: "plans#update_selected_mission"
  resources :plans
  resources :missions, only: [:index, :new, :create, :destroy, :edit, :update]
  root to: "plans#index"

end
