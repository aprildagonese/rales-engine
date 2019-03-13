Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :items, only: [:index, :show] do
        get '/best_day', to: 'item_dates#show', as: :best_day
      end
    end
  end
end
