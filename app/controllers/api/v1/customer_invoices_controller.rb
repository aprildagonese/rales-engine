class Api::V1::CustomerInvoicesController < ApplicationController
  def index
    customer = Customer.find(params[:id])
    invoices = customer.invoices
    render json: InvoiceSerializer.new(invoices)
  end
end
