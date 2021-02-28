Rails.application.routes.draw do
  constraints ->  request { request.session["warden.user.user.key"].present? } do
    root "outputs#index"
  end

  root 'toppage#index'

  resources :outputs
  resources :actions
  devise_for :users
  resources :books, only: %i[create show], shallow: true do
    collection do
      get :search
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
