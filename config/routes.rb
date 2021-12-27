Rails.application.routes.draw do
  get 'session/login'
  get 'session/create'
  get 'session/logout'
  resources :users
  resources :posts do
    collection do
      get :add, format: :json
    end
    end
  root 'posts#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
