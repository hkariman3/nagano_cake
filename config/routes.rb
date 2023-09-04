Rails.application.routes.draw do

devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}


scope module: :public do
root to:"homes#top"
get "/about" => "homes#about"
get "/cart_items/destroy_all" => "cart_items#destroy_all"

resources :items, only: [:index, :show]
get "/customers/unsubscribe" => "customers#unsubscribe"
patch "/customers/withdraw" => "customers#withdraw"
get "/orders/thanks" => "orders#thanks"

resources :customers, only: [:edit, :show, :update]

resources :cart_items, only: [:index, :update, :create, :destroy]

resources :orders, only: [:new, :index, :show, :create,:update]
post "/orders/confirm" => "orders#confirm"
get "/orders/complete" => "orders#complete"
resources :address, only: [:index, :edit, :create, :update, :destroy]



end

namespace :admin do

  get "/" => "homes#top"

  resources :items, only: [:index, :new, :create, :show, :edit, :update]

  resources :genres, only: [:index, :create, :edit, :update]

  resources :customers, only: [:index, :show, :edit, :update]

  resources :orders, only: [:show, :update]

  resources :order_details, only:[:update]

end

end
