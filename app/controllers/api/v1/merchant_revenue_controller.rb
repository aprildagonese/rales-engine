class Api::V1::MerchantRevenueController < ApplicationController
  include ActionView::Helpers::NumberHelper

  def index
    date = params[:date].to_date
    revenue = Revenue.new(Invoice.all_revenue_by_date(date))
    render json: TotalRevenueSerializer.new(revenue)
  end

  def show
    if params[:date]
      merchant = Merchant.find(params[:id])
      date = params[:date].to_date
      revenue = Revenue.new(merchant.revenue_by_date(date))
      render json: RevenueSerializer.new(revenue)
    else
      merchant = Merchant.find(params[:id])
      revenue = Revenue.new(merchant.revenue)
      render json: RevenueSerializer.new(revenue)
    end
  end
end
