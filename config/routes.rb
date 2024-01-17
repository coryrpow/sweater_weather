Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      # resources :forecast, only: [:show] do

      get "/forecast", to: "forecast#show"
      post "/users", to: "users#create"
      post "/sessions", to: "sessions#create"
      post "/road_trip", to: "road_trip#create"
      # end
    end
  end

  get "/api/v1/munchies", to: "api/v1/munchies#show"

end
