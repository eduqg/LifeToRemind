Rails.application.routes.draw do
  resources :plans
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :missions, only: [:new, :create, :destroy, :edit, :update]
  root to: "missions#index"

end
