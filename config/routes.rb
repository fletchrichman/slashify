Slashify::Application.routes.draw do
  get 'auth/:provider/callback', to: 'authenticate#create'
  get "authenticate/index"
  get "authenticate/create"

  get "photos", to: 'photos#index'
  post "photos", to: 'photos#create'
  get '/photos/:id', to: 'photos#show'

  root to: "pages#home"
end
