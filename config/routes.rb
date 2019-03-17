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
      get 'customers/:id/favorite_merchant', to: 'customer_merchants#show', as: :customer_merchants
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
      get 'merchants/:id/favorite_customer', to: 'merchant_customers#show', as: :merchant_customers
      get 'merchants/:id/customers_with_pending_invoices', to: 'merchant_customers#index', as: :merchant_customers_pending_invoices
      get 'merchants', to: 'merchants#index', as: :merchants
      get 'merchants/:id', to: 'merchants#show', as: :merchant

      get 'transactions/find_all', to: 'transactions_find#index', as: :find_transactions
      get 'transactions/find', to: 'transactions_find#show', as: :find_transaction
      get 'transactions/:id/invoice', to: 'transaction_invoice#show', as: :transaction_invoice
      get 'transactions', to: 'transactions#index', as: :transactions
      get 'transactions/:id', to: 'transactions#show', as: :transaction

      get 'invoices/find_all', to: 'invoices_find#index', as: :find_invoices
      get 'invoices/find', to: 'invoices_find#show', as: :find_invoice
      get 'invoices/:id/transactions', to: 'invoice_transactions#index', as: :invoice_transactions
      get 'invoices/:id/invoice_items', to: 'invoice_invoice_items#index', as: :invoice_invoice_items
      get 'invoices/:id/items', to: 'invoice_items#index', as: :invoice_items
      get 'invoices/:id/customer', to: 'invoice_customer#show', as: :invoice_customer
      get 'invoices/:id/merchant', to: 'invoice_merchant#show', as: :invoice_merchant
      get 'invoices', to: 'invoices#index', as: :invoices
      get 'invoices/:id', to: 'invoices#show', as: :invoice

      get 'invoiceitems/find_all', to: 'invoiceitems_find#index', as: :find_invoiceitems
      get 'invoiceitems/find', to: 'invoiceitems_find#show', as: :find_invoiceitem
      get 'invoiceitems/:id/invoice', to: 'invoiceitems_invoice#show', as: :invoiceitem_invoice
      get 'invoiceitems/:id/item', to: 'invoiceitems_item#show', as: :invoiceitem_item
      get 'invoiceitems', to: 'invoiceitems#index', as: :invoiceitems
      get 'invoiceitems/:id', to: 'invoiceitems#show', as: :invoiceitem

    end
  end
end
