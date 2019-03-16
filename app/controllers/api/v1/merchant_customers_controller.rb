class Api::V1::MerchantCustomersController < ApplicationController
  def show
    merchant = Merchant.find(params[:id])
    favorite_customer = merchant.favorite_customer
    render json: CustomerSerializer.new(favorite_customer)
  end

  def index
    merchant = Merchant.find(params[:id])
    customers = merchant.customers_with_pending_invoices
    render json: CustomerSerializer.new(customers)
  end
end
