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

resources :items, only: [:index, :show]

resources :customers, only: [:edit, :show, :update]
get "/customers/unsubscribe" => "customers#unsubscribe"
get "/customers/withdraw" => "customers#withdraw"

resources :cart_items, only: [:index, :update, :create, :destroy]
get "/cart_items/destroy_all" => "/cart_items#destroy_all"

resources :orders, only: [:new, :index, :show]
get "/orders/confirm" => "orders#confirm"
get "/orders/complete" => "orders#complete"

resources :address, only: [:index, :edit, :create, :update, :destroy]

end

namespace :admin do


end

end
