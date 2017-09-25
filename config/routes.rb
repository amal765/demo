Rails.application.routes.draw do
  devise_for :users, controllers: { passwords: 'users/passwords',registrations: 'users/registrations' }
  resources :users
  resources :groups do
    member do
      get '/memberdestroy', to: 'groups#memberdestroy', as:"memberdestroy"
    end
  end
  root "groups#index"
  post '/inviter', to: 'users#inviter'
  get "/invite/:id", to: "users#invite", as: "invite"
  post '/custom_update', to: 'users#custom_update'
  get "/custom_new/:id", to: "users#custom_new", as: "custom_new"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
