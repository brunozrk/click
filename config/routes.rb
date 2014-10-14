Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  authenticate :user do
    root 'dashboards#index'

    resources :reports
  end
end
