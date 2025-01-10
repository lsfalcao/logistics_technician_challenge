Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "api/v1/legacy_orders#index"

  devise_for :clients, path: "api/v1",
    path_names: {
      sign_in: "login",
      sign_out: "logout",
      registration: "signup"
    },
    controllers: {
      sessions: "api/v1/clients/sessions",
      registrations: "api/v1/clients/registrations"
    }

  namespace :api do
    namespace :v1 do
      resources :orders, only: [:index, :show, :create, :update, :destroy]
      resources :order_products, only: [:index, :show, :create, :update, :destroy]
      resources :users, only: [:index, :show, :create, :update, :destroy]
      resources :legacy_order_imports, only: [:index, :show, :create, :destroy]
      get "legacy_orders" => "legacy_orders#index"
    end
  end
end
