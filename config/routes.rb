Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "landing_page#index"

  namespace :admin do
    get 'dashboard/index'
    root to: 'dashboard#index', as: 'dashboard'
    resources :users do
      member do
        patch :approve
        delete :deny
      end
      collection do
        get :invite_user_form
        post :invite_user
      end
    end
    resources :adoption_applications, only: [:index, :show]
    resources :adopters, only: [:edit, :update]
    resources :shelters, only: [:edit, :update]
  end

  devise_scope :user do
    get 'invite_user/:invitation_token', to: 'users/registrations#new_invited_user', as: 'new_invitation'
    post 'create_user', to: 'users/registrations#create_invited_user'
  end

  namespace :adopter do
    get 'dashboard', to: 'dashboard#index'
    resources :favorites, only: [:index, :create, :destroy]
    resources :pets, only: [:index, :show, :create]
    resources :adoptions
  end
  
end
