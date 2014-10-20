Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  devise_scope :user do
    get 'success', action: 'success', controller: 'registrations', as: 'success'

    authenticated :user do
      root 'dashboards#index'
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  resources :reports
end
