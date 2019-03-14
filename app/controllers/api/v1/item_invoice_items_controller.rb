class Api::V1::ItemInvoiceItemsController < ApplicationController
  def index
    item = Item.find(params[:id])
    invoice_items = item.invoice_items
    render json: InvoiceItemSerializer.new(invoice_items)
  end
end
