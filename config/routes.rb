Rails.application.routes.draw do
  get 'chats/show'
  devise_for :user, skip: [:passwords], controllers: {
    registrations: 'public/registrations',
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: %i[registrations passwords], controllers: {
    sessions: 'admin/sessions'
  }

  namespace :admin do
    root to: 'homes#top'
    resources :users, only: %i[show edit update]
    resources :events, only: %i[index destroy]
    get '/search', to: 'searches#search'
  end

  scope module: :public do
    root to: 'homes#top'
    get 'users/user_all' => 'users#user_all', as: 'user_all'
    get 'users/:id/erasure' => 'users#erasure', as: 'erasure_user'
    patch 'users/:id/leave' => 'users#leave', as: 'leave_user'
    get 'users/:id/index' => 'users#index', as: 'users'
    get 'users/bookmark' => 'users#bookmark', as: 'bookmark'
    resources :users, only: %i[show edit update] do
      resource :relationships, only: %i[create destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end
    resources :events, only: %i[index new show create edit update destroy] do
      resources :event_comments, only: %i[create destroy]
      resource :bookmarks, only: %i[create destroy]
    end
    resources :groups do
      get 'join' => 'groups#join'
      get 'new/mail' => 'groups#new_mail'
      get 'send/mail' => 'groups#send_mail'
    end
    get 'users/:id/calender' => 'users#calender', as: 'calender_user'
    resources :rooms, only: %i[create index show]
    resources :chats, only: [:create]
    get '/search', to: 'searches#search'
    resources :calendars
    resources :notifications, only: :index
  end
  
  resources :contacts, only: [:new, :create]
  post 'contacts/confirm', to: 'contacts#confirm', as: 'confirm'
  post 'contacts/back', to: 'contacts#back', as: 'back'
  get 'done', to: 'contacts#done', as: 'done'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
