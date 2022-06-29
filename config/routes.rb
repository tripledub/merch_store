Rails.application.routes.draw do
  namespace :api do
    resources :health_check, only: [:index]

    namespace :v1 do
      resources :products, only: %i[index update]
      resources :price_check, only: %i[create]
    end
  end
end
