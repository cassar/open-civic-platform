Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :memberships, only: :destroy
  resources :invitations, only: [:update, :destroy]

  resources :groups, except: :destroy do
    resources :invitations, only: [:new, :create], controller: 'groups/invitations'
    resources :issues, only: [:show, :new, :create], controller: 'groups/issues'
  end

  resources :issues do
    resources :positions, only: [:new, :create], controller: 'issues/positions'
  end

  root 'groups#index'
end
