class Api::V1::ItemMerchantsController < ApplicationController
  def show
    item = Item.find(params[:id])
    merchant = item.merchant
    render json: MerchantSerializer.new(merchant)
  end
end
