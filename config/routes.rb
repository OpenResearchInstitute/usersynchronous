Rails.application.routes.draw do
  devise_for :users

  root controller: 'main', action: 'index'
end
