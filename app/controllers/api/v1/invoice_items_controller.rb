class Api::V1::InvoiceItemsController < ApplicationController
  def index
    invoice = Invoice.find(params[:id])
    items = invoice.items
    render json: ItemSerializer.new(items)
  end
end
