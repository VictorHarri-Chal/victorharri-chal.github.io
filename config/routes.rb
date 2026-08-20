Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root to: "pages#home"

  get "/about", to: "pages#about"
  get "/experience", to: "pages#experience"
  get "/contact", to: "pages#contact"
  # Not /404: ActionDispatch::Static would serve public/404.html for that path
  # before the router ever sees it. The build writes this page to _site/404.html.
  get "/not-found", to: "pages#not_found"

  resources :projects, only: %i[index show]
end
