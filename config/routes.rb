Rails.application.routes.draw do
  devise_for :users
  root "pages#index"
  get "about", to: "pages#about"

  # get "up" => "rails/health#show", as: :rails_health_check
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  authenticate :user do
    get "dashboard", to: "trips#index", as: :user_root
    resources :trips do
      resources :destinations
      resources :itineraries do
        resources :activities
      end
    end
  end
end
