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
    resources :positions, only: :show
  end

  get 'home', to: 'profiles#show'

  root 'static_pages#landing'
end
