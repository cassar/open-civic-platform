Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new'
    get 'sign_up', to: 'devise/registrations#new'
    get 'sign_out', to: 'devise/sessions#destroy'
    get 'account', to: 'devise/registrations#edit'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :memberships, only: :destroy
  resources :invitations, only: [:update, :destroy]
  resources :profiles, only: [:edit, :update]

  resources :groups, except: :destroy do
    resources :invitations, only: [:new, :create], controller: 'groups/invitations'
    resources :issues, only: [:show, :new, :create], controller: 'groups/issues'
  end

  resources :issues do
    resources :positions, only: [:new, :create, :show], controller: 'issues/positions'
  end

  resources :positions, only: [] do
    resources :supports, only: [:create, :destroy, :update], controller: 'positions/supports'
    resources :issues, only: [:new, :create], controller: 'positions/issues'
  end

  resources :supports, only: [] do
    member { patch :toggle_subscription }
  end

  get 'complete_profile', to: 'profiles#edit'

  root 'static_pages#landing_page'
end
