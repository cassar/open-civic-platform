Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :memberships, only: :destroy
  resources :invitations, only: [:update, :destroy]
  resources :profiles, only: [:edit, :update]

  resources :groups, except: :destroy do
    resources :invitations, only: [:new, :create], controller: 'groups/invitations'
    resources :issues, only: [:show, :new, :create], controller: 'groups/issues'
  end

  resources :issues do
    resources :positions, only: [:new, :create], controller: 'issues/positions'
  end

  resources :positions, only: [] do
    resources :supports, only: [:create, :destroy, :update], controller: 'positions/supports'
  end

  get 'complete_profile', to: 'profiles#edit'

  root 'static_pages#coming_soon'
end
