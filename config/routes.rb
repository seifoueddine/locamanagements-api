Rails.application.routes.draw do

  



  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users
  namespace :api do
    scope :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
    end
  end

  namespace :api do
    namespace :v1 do
      resources :articles
      resources :slugs
      resources :users
      put 'users/change_password/:id', to: 'users#change_password'
      get 'appointments/calendar_appointments', to: 'appointments#calendar_appointments'
      resources :contacts
      resources :properties
      resources :appointments
      resources :contracts
      resources :notifications
      get 'dashboard/appointments', to: 'dashboard#appointments'
      mount ActionCable.server => '/cable'
    end
   end



end
