Rails.application.routes.draw do
  # Leave this devise line first, so that it is registered before the user resources.
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  delete "omniauth_logins/:id", to: "omniauth_logins#destroy", as: "omniauth_logins"

  resources :posts do
    get :comments, to: "comments#index"
  end
  resources :comments, only: [ :create, :update, :destroy ]
  resources :likes, only: [ :create, :destroy ]

  resource :profile
  resolve("Profile") { [ :profile ] }

  resources :users, only: [ :index, :show ] do
    post :follow, to: "followings#create"
    delete :unfollow, to: "followings#destroy", as: "unfollow"
  end
  resources :followings

  get "static/dev_console"

  root "posts#index"





  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
