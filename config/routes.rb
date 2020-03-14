Rails.application.routes.draw do
  devise_for :users

  root "tops#index"
  resources :tops,only: :index 
  resources :categories,only: :index, defaults: {format: 'json'}
  resources :product_sizes,only: :index, defaults: {format: 'json'}
  resources :shippingways,only: :index, defaults: {format: 'json'}
  resources :sign_ups, only: :create do
    collection do
      get 'index'
      get 'step1'
      get 'step2'
      get 'done'
    end
  end
  resources :items do
    resources :trades , only: [:index,:new,:create,:show,:update] do
      collection do
        get 'fail', to: 'trades#fail'
      end
    end
  end
  resources :users , only: :show do
    resources :creditcards, only: [:new, :show, :destroy] do
      collection do
        post 'pay', to: 'creditcards#pay'
        post 'show', to: 'creditcards#show'
      end
    end
    resources :addresses, only: [:index,:new, :edit, :update]
  end

end
