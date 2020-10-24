# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new'
    get 'sign_up', to: 'devise/registrations#new'
    get 'sign_out', to: 'devise/sessions#destroy'
    get 'account', to: 'devise/registrations#edit'
  end

  resources :issues, only: [:index, :show] do
    resources :positions, only: :show do
      resources :links, only: [:new, :create, :destroy], controller: 'issues/positions/links'
    end
    resources :links, only: [:new, :create, :destroy], controller: 'issues/links'
  end

  get 'profile', to: 'profiles#show'

  namespace :profile do
    resources :issues, except: [:index, :destroy] do
      resources :positions, except: [:index, :destroy] do
        resources :supports, only: [:create, :destroy]
      end
    end
    resources :preferences, only: :update
  end

  root 'issues#index'
end
