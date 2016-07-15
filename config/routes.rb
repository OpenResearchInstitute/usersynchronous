Rails.application.routes.draw do

  get 'graph/data', defaults: {format: 'json'}
  get 'graph', controller: 'graph', action: 'index'

  devise_for :users

  root controller: 'main', action: 'index'
end
