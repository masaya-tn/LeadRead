Rails.application.routes.draw do
  root 'outputs#index'
  resources :outputs
  devise_for :users
  resources :books, only: %i[create show], shallow: true do
    collection do
      get :search
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
