Rails.application.routes.draw do
  get 'graph/index'
  get 'graph/data', defaults: {format: 'json'}

  devise_for :users

  root controller: 'main', action: 'index'
end
