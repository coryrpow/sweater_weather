Rails.application.routes.draw do
  # namespace :api do
  #   namespace :v0 do
  #     resources :forecast, only: [:show] do

  #     end
  #   end
  # end
  get "/api/v0/forecast", to: "api/v0/forecast#show"

end
