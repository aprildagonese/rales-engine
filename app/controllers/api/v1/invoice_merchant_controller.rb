class Api::V1::InvoiceMerchantController < ApplicationController
  def show
    invoice = Invoice.find(params[:id])
    merchant = invoice.merchant
    render json: MerchantSerializer.new(merchant)
  end
end
