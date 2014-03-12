Slashify::Application.routes.draw do
  get 'auth/:provider/callback', to: 'authenticate#create'
  get "authenticate/index"
  get "authenticate/create"
end
