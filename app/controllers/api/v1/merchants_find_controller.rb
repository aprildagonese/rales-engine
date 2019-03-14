class Api::V1::MerchantsFindController < ApplicationController

  def index
    if params[:id]
      @merchants = Merchant.where(id: params[:id])
    elsif params[:name]
      @merchants = Merchant.where(name: params[:name])
    elsif params[:created_at]
      @merchants = Merchant.where(created_at: params[:created_at])
    elsif params[:updated_at]
      @merchants = Merchant.where(updated_at: params[:updated_at])
    end
    render json: MerchantSerializer.new(@merchants)
  end

  def show
    if params[:id]
      @merchant = Merchant.find(params[:id])
    elsif params[:name]
      @merchant = Merchant.find_by(name: params[:name])
    elsif params[:created_at]
      @merchant = Merchant.find_by(created_at: params[:created_at])
    elsif params[:updated_at]
      @merchant = Merchant.find_by(updated_at: params[:updated_at])
    end
    render json: MerchantSerializer.new(@merchant)
  end

end
