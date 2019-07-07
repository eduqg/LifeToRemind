Rails.application.routes.draw do
  resources :contacts, only: [:index, :show, :new, :create, :destroy]

  resources :roles
  put "csfs/update_selected_csf", to: "csfs#update_selected_csf"
  resources :csfs
  resources :values
  put "visions/update_selected_vision", to: "visions#update_selected_vision"
  resources :visions, only: [:index, :new, :create, :destroy, :edit, :update]
  resources :activities do
    collection do
      put :checked
    end
  end
  resources :goals

  get "spheres/update_sphere_completion", to: "spheres#update_sphere_completion"
  get "sphereobjectives", to: "spheres#sphereobjectives"
  resources :spheres

  get "editobjective", to: "objectives#editobjective"
  resources :objectives

  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations" }
  devise_scope :user do
    get 'users', :to => 'users/registrations#index'
    delete 'users/destroy_another_user', :to => 'users/registrations#destroy_another_user'
  end
  resources :swotparts

  put "missions/update_selected_mission", to: "missions#update_selected_mission"
  resources :missions, only: [:index, :new, :create, :destroy, :edit, :update]

  get "plans/import_page", to: "plans#import_page"
  get "plans/export", to: "plans#export"
  get "plans/pdf", to: "plans#pdf"
  put "plans/update_selected_plan", to: "plans#update_selected_plan"
  get "swot", to:"plans#swot"
  get "myplan", to: "plans#myplan"
  get "plans/swotedit", to: "plans#swotedit"
  get "inicio", to:"plans#inicio"
  resources :plans do
    collection { post :import }
  end

  get "home/contribution", to: "home#contribution"
  root to: "home#index"
end
