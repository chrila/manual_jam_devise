Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  devise_scope :user do
    get '/users/admin', to: 'users/registrations#admin', as: 'user_admin'
    delete '/users/:user_id', to: 'users/registrations#destroy', as: 'user_registration_id'
  end

  resources :stories

  get '/stories_user', to: 'stories#user', as: 'user_stories'
  root 'stories#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
