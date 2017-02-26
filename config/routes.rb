Rails.application.routes.draw do
  root 'houses#index'
  put '/settings', to: 'settings#update', as: :update_settings
  resources :settings
  resources :houses do
    resources :features
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
