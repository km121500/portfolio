Rails.application.routes.draw do
devise_for :user,skip: [:passwords,], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

devise_for :admin,skip: [:registrations, :passwords] , controllers: {
  sessions: "admin/sessions"
}

namespace :admin do
  resources :uers, only: [:index, :show, :edit, :update]
end

scope module: :public do
  get 'user/:id/erasure'=>'users#erasure', as: 'erasure_user'
  patch 'users/:id/leave'=>'users#leave', as: 'leave_user'
  resources :users,only: [:show,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  resources :events,only:  [:new, :create, :index, :show, :edit, :destroy] do
    resources :event_comments,only: [:create, :destroy]
  end
  
end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
