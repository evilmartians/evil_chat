Rails.application.routes.draw do
  root "chat#show"

  get "/login",  to: "auth#new"
  post "/login", to: "auth#create"
end
