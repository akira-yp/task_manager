Rails.application.routes.draw do
  namespace :admin do
    resources :users
    resources :tags
  end
  root 'sessions#new'
  resources :tasks
  resources :users
  resources :sessions, only:[:new, :create, :destroy]
end
