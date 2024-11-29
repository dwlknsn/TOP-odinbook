Rails.application.routes.draw do
  resources :posts do
    resources :likes, only: [ :create, :destroy ]
  end

  resource :profile
  resolve("Profile") { [ :profile ] }

  resources :users, only: [ :index, :show ] do
    post :follow, to: "followings#create"
    delete :unfollow, to: "followings#destroy", as: "unfollow"
    patch :accept, to: "followings#accept"
    patch :decline, to: "followings#decline"
    patch :block, to: "followings#block"
  end


  root "posts#index"

  devise_for :users






  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
