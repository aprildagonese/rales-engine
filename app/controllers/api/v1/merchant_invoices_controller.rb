class Api::V1::MerchantInvoicesController < ApplicationController
  def index
    merchant = Merchant.find(params[:id])
    invoices = merchant.invoices
    render json: InvoiceSerializer.new(invoices)
  end
end
