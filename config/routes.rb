require 'sidekiq/web'

WevorceEcosign::Application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  resources :documents do
    collection do
      patch :email_blueprint
      post :email_blueprint
      get 'access/:key', action: :public_access, as: :public
      post 'access/:key/purchase', controller: :purchase, action: :create, as: :purchase
    end
    get :email, on: :member
  end

  resources :signatures, only: [:update]

  root to: 'documents#index'
end
