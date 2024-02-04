Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  get "/dnd_campaigns", to: "dnd_campaigns#index"
  get "/dnd_campaigns/:id", to: "dnd_campaigns#show"

  get "/players", to: "players#index"
  get "/players/:id", to: "players#show"

  get "/dnd_campaigns/:id/players", to: "dnd_campaign_players#index"
end