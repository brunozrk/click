Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  devise_scope :user do
    get 'success', action: 'success', controller: 'registrations', as: 'success'

    authenticated :user do
      root 'dashboards#index'
    end

    unauthenticated do
      root 'site#index', as: :unauthenticated_root
    end
  end

  resources :reports do
    get 'export', on: :collection
  end

  resources :timetables

  resources :site, only: :index do
    get 'como-funciona', action: 'how_it_works', as: 'how_it_works', on: :collection
  end
end
