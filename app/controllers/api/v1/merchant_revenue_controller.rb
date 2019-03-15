class Api::V1::MerchantRevenueController < ApplicationController
  include ActionView::Helpers::NumberHelper

  def show
    date = params[:date].to_date
    revenue = Revenue.new(number_to_currency(Invoice.revenue(date), unit: "").to_str)
    render json: RevenueSerializer.new(revenue)
  end
end
