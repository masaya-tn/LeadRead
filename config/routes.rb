Rails.application.routes.draw do
  root 'outputs#index'
  resources :outputs
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
