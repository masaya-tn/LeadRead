Rails.application.routes.draw do
  constraints ->  request { request.session["warden.user.user.key"].present? } do
    root "outputs#index"
  end

  root 'toppage#index'

  resources :outputs
  get 'output_search', to: 'outputs#search'
  resources :likes, only: %i[create destroy]
  resources :action_plans
  resources :meetings, shallow: true do
    resources :messages
  end
  get 'meeting_search', to: 'meetings#search'
  resources :requestings, only: %i[create destroy]
  resources :participants, only: %i[create destroy]
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  resources :relationships, only: %i[create destroy]
  resources :books, only: %i[create show], shallow: true do
    collection do
      get :search
    end
  end
  
  resources :users, only: [:show]
  resource :profile, only: %i[index edit update]
  resources :notifications do
    resource :read, only: %i[create]
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
  
end
