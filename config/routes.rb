Rails.application.routes.draw do

  devise_for :users
  root to: 'homes#top'
  resources :books, only: [:create, :index, :show, :destroy, :edit, :update]
  resources :users, only: [:index, :show, :edit, :update]
end