Rails.application.routes.draw do

  root to: 'homes#top'

  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  devise_for :admins, skip: [:registrations, :passwords] , controllers: {
  sessions: "admin/sessions"
}

  namespace :public do
    resources :items, only: [:new,:index,:show,:edit,:create,:update,:destroy]
       end

  namespace :public do
    resources :customers
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
