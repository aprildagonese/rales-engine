class Api::V1::CustomerMerchantsController < ApplicationController
  def show
    customer = Customer.find(params[:id])
    merchant = customer.favorite_merchant
    render json: MerchantSerializer.new(merchant)
  end
end
