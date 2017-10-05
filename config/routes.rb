Rails.application.routes.draw do
  devise_for :users, controllers: { passwords: 'users/passwords',registrations: 'users/registrations' }
  resources :users
  resources :tasks, only: [:create, :destroy, :update]
  resources :groups do
    member do
      get '/member_destroy', to: 'groups#member_destroy', as:"member_destroy"
      get '/delete_modal', to: 'groups#delete_modal'
    end
  end
  root "groups#index"
  post '/inviter', to: 'users#inviter'
  post '/custom_update', to: 'users#custom_update'
  get "/custom_new/:id", to: "users#custom_new", as: "custom_new"
  get '/profile_edit', to: "users#profile_edit"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
