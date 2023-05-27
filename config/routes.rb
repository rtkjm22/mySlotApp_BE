Rails.application.routes.draw do
  resources :users, only: %i[new create show edit update]
  resources :scores, only: %i[new create show edit update]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#new'
end
