class Api::V1::InvoiceInvoiceItemsController < ApplicationController
  def index
    invoice = Invoice.find(params[:id])
    invoice_items = invoice.invoice_items
    render json: InvoiceItemSerializer.new(invoice_items)
  end
end
