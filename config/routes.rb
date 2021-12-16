Rails.application.routes.draw do
  get 'chats/show'
devise_for :user,skip: [:passwords,], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

devise_for :admin,skip: [:registrations, :passwords] , controllers: {
  sessions: "admin/sessions"
}

namespace :admin do
  root to: 'homes#top'
  resources :users, only: [:show, :edit, :update]
end

scope module: :public do
  root to: 'homes#top'
  get 'users/:id/erasure'=>'users#erasure', as: 'erasure_user'
  patch 'users/:id/leave'=>'users#leave', as: 'leave_user'
  get 'users/:id/index' => 'users#index', as: 'users'
  get 'users/bookmark' => 'users#bookmark', as: 'bookmark'
  resources :users,only: [:show,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  resources :events,only: [:new,:show,:create,:edit,:update,:destroy] do
    resources :event_comments,only: [:create, :destroy]
    resource :bookmarks, only: [:create, :destroy]
  end
  resources :groups do
    get "join" => "groups#join"
    get "new/mail" => "groups#new_mail"
    get "send/mail" => "groups#send_mail"
  end
  get 'users/:id/calender'=>'users#calender', as: 'calender_user'
  resources :calenders
  get 'chat/:id', to: 'chats#show', as: 'chat'
  resources :chats, only: [:create]
end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
