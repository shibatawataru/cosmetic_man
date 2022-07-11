Rails.application.routes.draw do

  root to: 'homes#top'

  devise_scope :customer do
    post 'customers/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions',
    passwords: 'public/passwords'
  }
  
  # 退会確認画面
  get '/customers/:id/unsubscribe' => 'public/customers#unsubscribe', as: 'customer_unsubscribe'
  # 論理削除用のルーティング
  patch '/customers/:id/withdrawal' => 'public/customers#withdrawal', as: 'customers_withdrawal'

  devise_for :admins, skip: [:registrations, :passwords] , controllers: {
    sessions: "admin/sessions"
  }

  namespace :public do
    get '/items/tag_search', to: 'items#tag_search'
    resources :items, only: [:new, :index, :show, :edit, :create, :update, :destroy] do
      resources :comments, only: [:create, :destroy]
    end
  end

  namespace :public do
    resources :customers
  end

  namespace :admin do
    get '/items/tag_search', to: 'items#tag_search'
    resources :items, only: [:index, :show, :destroy]
  end

  namespace :admin do
    resources :customers
  end

  namespace :admin do
    resources :tags, only: [:index, :edit, :create, :update, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
