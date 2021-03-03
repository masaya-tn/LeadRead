Rails.application.routes.draw do
  constraints ->  request { request.session["warden.user.user.key"].present? } do
    root "outputs#index"
  end

  root 'toppage#index'

  resources :outputs
  resources :likes, only: %i[create destroy]
  resources :action_plans
  resources :meetings
  devise_for :users
  resources :books, only: %i[create show], shallow: true do
    collection do
      get :search
    end
  end
  
  resources :users, only: [:show]
  resource :profile, only: %i[index edit update]
  
end
