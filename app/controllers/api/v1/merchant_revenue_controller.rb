class Api::V1::MerchantRevenueController < ApplicationController
  include ActionView::Helpers::NumberHelper

  def show
    binding.pry
    revenue = Invoice.revenue(params[:date])
  end
end
