Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  resources :list_of_users, only: [:index]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "landing_page#index"
  # admin
  namespace :admin do
    get 'dashboard/index'
    root to: 'dashboard#index', as: 'dashboard'
    # users
    resources :users do
      member do
        patch :approve
        delete :deny
        get 'chat'
      end
      # invite_user
      collection do
        get :invite_user_form
        post :invite_user
      end
      # post send message
      post 'send_message', on: :member, controller: 'messages'

    end
    resources :adoption_applications, only: [:index, :show]
    resources :adopters, only: [:edit, :update]
    resources :shelters, only: [:edit, :update]
    resources :pets, only: [:show]
  end

  devise_scope :user do
    get 'invite_user/:invitation_token', to: 'users/registrations#new_invited_user', as: 'new_invitation'
    post 'create_user', to: 'users/registrations#create_invited_user'
  end

  namespace :adopter do
    get 'dashboard', to: 'dashboard#index'
    resources :favorites, only: [:index, :create, :destroy]
    resources :pets, only: [:index, :show, :create] do
      resources :comments, only: [:create, :destroy]
    end
    resources :adoption_applications
  end

  namespace :shelter_namespace, path: 'shelter' do
    get 'dashboard', to: 'dashboard#index'
    resources :pets do
      member do
        patch :update_status
        delete :delete_photo  # Adding this line for the delete photo action
      end
      collection do
        post :uploads  # Adding this line for the uploads action in the create new pet view for shelters
      end
      resources :pet_comments, only: [:create]
    end
    resources :adoption_applications, only: [:index, :show, :edit, :update] do
      member do
        patch :approve
        patch :deny
        patch :pending
      end
    end
    resources :adopters, only: [:show]
    resources :chats, only: [:index, :show, :create]
  end

  namespace :sendbird do
    post '/create_group_channel_to_sendbird', to: 'sendbird#create_group_channel_to_sendbird'
    get 'list_users', to: 'sendbird#list_users'
    post 'send_message_to_sendbird', to: 'sendbird#send_message_to_sendbird'
    get 'fetch_messages', to: 'sendbird#fetch_messages'
  end

  # resources :list_of_users, only: [:index]
end