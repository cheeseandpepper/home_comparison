Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }
  root 'houses#index'
  put '/settings', to: 'settings#update', as: :update_settings
  resources :settings
  resources :houses do
    collection do 
      post :save_from_web
    end

    get :comps, to: 'comps#index', as: :comps_index
    
    resources :features
    resources :comments
    member do
      post :unhide
    end
  end

  resources :feature_types
  resources :open_houses

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
