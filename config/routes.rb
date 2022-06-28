Rails.application.routes.draw do
  # get 'products/index'
  # get 'health_check/index'

  namespace :api do
    resources :health_check, only: [:index]

    namespace :v1 do
      resources :products, only: [:index]
    end
  end
end
