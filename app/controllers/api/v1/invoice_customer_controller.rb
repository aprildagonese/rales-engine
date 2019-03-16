class Api::V1::InvoiceCustomerController < ApplicationController
  def show
    invoice = Invoice.find(params[:id])
    customer = invoice.customer
    render json: CustomerSerializer.new(customer)
  end
end
