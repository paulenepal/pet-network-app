Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'registrations'
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
        get :invite_shelter_form
        post :invite_shelter
      end
    end
    resources :adoption_applications, only: [:index, :show]
    resources :adopters, only: [:edit, :update]
    resources :shelters, only: [:edit, :update]
  end

  devise_scope :user do
    get 'invite_shelter/:invitation_token', to: 'registrations#new_shelter', as: 'new_shelter_invitation'
    post 'create_shelter', to: 'registrations#create_shelter'
  end
end
