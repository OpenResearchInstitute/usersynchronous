Rails.application.routes.draw do

  get 'graph/data', defaults: {format: 'json'}
  get 'graph', controller: 'graph', action: 'index'

  devise_for :users

  resources :users, only: [:show, :edit, :update, :destroy] do
    resources :log_files
  end

  root controller: 'main', action: 'index'
end
