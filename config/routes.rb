Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  # Parent Routes
  get "/dnd_campaigns", to: "dnd_campaigns#index"
  get "/dnd_campaigns/new", to: "dnd_campaigns#new"
  post "/dnd_campaigns", to: "dnd_campaigns#create"
  get "/dnd_campaigns/:id", to: "dnd_campaigns#show"
  get "/dnd_campaigns/:id/edit", to: "dnd_campaigns#edit"
  patch "/dnd_campaigns/:id", to: "dnd_campaigns#update"

  # Child Routes
  get "/players", to: "players#index"
  get "/players/:id", to: "players#show"
  get "/players/:id/edit", to: "players#edit"
  patch "/players/:id", to: "players#update"

  # Parent's Children Routes
  get "/dnd_campaigns/:id/players", to: "dnd_campaign_players#index"
  get "/dnd_campaigns/:id/players/new", to: "dnd_campaign_players#new"
  post "/dnd_campaigns/:id/players", to: "dnd_campaign_players#create"
end