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
  devise_for :admins, skip: [:registrations, :passwords] , controllers: {
  sessions: "admin/sessions"
}

  namespace :public do
    resources :items, only: [:new, :index, :show, :edit, :create, :update, :destroy] do
    resources :comments, only: [:create, :destroy]
  end
  end

  namespace :public do
    resources :customers
  end

  namespace :admin do
    resources :items, only: [:index, :show, :destroy]
  end

  namespace :admin do
    resources :customers
  end

  namespace :admin do
    resources :tags, only: [:new, :index, :edit, :create, :update, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
