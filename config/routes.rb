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
      get 'customers/:id/favorite_merchant', to: 'customer_merchants#index', as: :customer_merchants
      get 'customers', to: 'customers#index', as: :customers
      get 'customers/:id', to: 'customers#show', as: :customer

      get 'merchants/find_all', to: 'merchants_find#index', as: :find_merchants
      get 'merchants/find', to: 'merchants_find#show', as: :find_merchant
      get 'merchants/:id/items', to: 'merchant_items#index', as: :merchant_items
      get 'merchants/:id/invoices', to: 'merchant_invoices#index', as: :merchant_invoices
      get 'merchants/most_revenue', to: 'merchant_most_revenue#index', as: :merchant_most_revenue
      get 'merchants/most_items', to: 'merchant_most_items#index', as: :merchant_most_items
      get 'merchants/revenue', to: 'merchant_revenue#index', as: :days_revenue
      get 'merchants/:id/revenue', to: 'merchant_revenue#show', as: :merchant_revenue
      get 'merchants', to: 'merchants#index', as: :merchants
      get 'merchants/:id', to: 'merchants#show', as: :merchant

    end
  end
end
