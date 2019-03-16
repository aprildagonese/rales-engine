class Api::V1::MerchantRevenueController < ApplicationController
  include ActionView::Helpers::NumberHelper

  def index
    date = params[:date].to_date
    revenue = Revenue.new(number_to_currency(Invoice.all_revenue_by_date(date), unit: "").to_str)
    render json: RevenueSerializer.new(revenue)
  end

  def show
    if params[:date]
      merchant = Merchant.find(params[:id])
      date = params[:date].to_date
      revenue = Revenue.new(number_to_currency(merchant.revenue_by_date(date), unit: "").to_str)
      render json: RevenueSerializer.new(revenue)
    else
      merchant = Merchant.find(params[:id])
      revenue = Revenue.new(number_to_currency(merchant.revenue, unit: "").to_str)
      render json: RevenueSerializer.new(revenue)
    end
  end
end
