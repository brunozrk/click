Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  devise_scope :user do
    get 'success', action: 'success', controller: 'registrations', as: 'success'
  end

  authenticated :user do
    root 'dashboards#index'
  end

  resources :reports
end
