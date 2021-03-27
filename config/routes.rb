Rails.application.routes.draw do
  root 'sessions#new'
  resources :tasks
  resources :users
  resources :sessions, only:[:new, :create, :destroy]
end
