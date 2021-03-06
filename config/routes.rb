Rails.application.routes.draw do
  constraints ->  request { request.session["warden.user.user.key"].present? } do
    root "outputs#index"
  end

  root 'toppage#index'

  resources :outputs
  get 'search', to: 'outputs#search'
  resources :likes, only: %i[create destroy]
  resources :action_plans
  resources :meetings, shallow: true do
    resources :messages
  end
  resources :requestings, only: %i[create destroy]
  resources :participants, only: %i[create destroy]
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  resources :books, only: %i[create show], shallow: true do
    collection do
      get :search
    end
  end
  
  resources :users, only: [:show]
  resource :profile, only: %i[index edit update]
  
end
