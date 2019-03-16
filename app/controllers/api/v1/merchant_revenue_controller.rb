class Api::V1::MerchantRevenueController < ApplicationController
  include ActionView::Helpers::NumberHelper

  def index
    date = params[:date].to_date
    revenue = Revenue.new(number_to_currency(Invoice.revenue(date), unit: "").to_str)
    render json: RevenueSerializer.new(revenue)
  end

  def show
    if params[:date]
    else
    end 
  end
end
