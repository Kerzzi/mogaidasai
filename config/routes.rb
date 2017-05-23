Rails.application.routes.draw do

  get 'product_images/controller'

  get 'static_pages/about'
  get 'static_pages/help'
  get 'static_pages/contact'

  devise_for :users
  root 'products#index'

  namespace :admin do
    root 'static_pages#about'
    resources :products do
      resources :product_images, only: [:index, :create, :destroy, :update]
    end
    resources :categories
    resources :orders do
      member do
        post :cancel
        post :ship
        post :shipped
        post :return
      end
    end
  end

  resources :categories, only: [:show]

  resources :products do
    member do
      post :add_to_cart
    end
  end

  resources :carts do
   collection do
     delete :clean
     post :checkout
   end
  end

  namespace :account do
    resources :orders
  end

  resources :orders do
    member do
      post :pay_with_alipay
      post :pay_with_wechat
      post :apply_to_cancel
    end
  end

  resources :cart_items
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
