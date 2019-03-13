Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'items/:id/best_day', to: 'item_dates#show', as: :best_day
      get 'items/find', to: 'item_find#show', as: :find_item
      get 'items/find_all', to: 'item_find#index', as: :find_items
      get 'items', to: 'items#index', as: :items
      get 'items/:id/', to: 'items#show', as: :item
      get 'items/most_items', to: 'items#show', as: :most_items
      get 'items/most_revenue', to: 'items#show', as: :most_revenue
    end
  end
end
