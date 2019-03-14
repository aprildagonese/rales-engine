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
      get 'items/:id/invoice_items', to: 'item_invoice_items#index', as: :item_invoice_items
      get 'items/:id/merchant', to: 'item_merchants#show', as: :item_merchant

      get 'customers/find_all', to: 'customers_find#index', as: :find_customers
      get 'customers/find', to: 'customers_find#show', as: :find_customer
      get 'customers/:id/invoices', to: 'customer_invoices#index', as: :customer_invoices
      get 'customers/:id/transactions', to: 'customer_transactions#index', as: :customer_transactions
      get 'customers', to: 'customers#index', as: :customers
      get 'customers/:id', to: 'customers#show', as: :customer
    end
  end
end
