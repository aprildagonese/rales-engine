class Api::V1::InvoiceitemsItemController < ApplicationController
  def show
    invoiceitem = InvoiceItem.find(params[:id])
    item = invoiceitem.item
    render json: ItemSerializer.new(item)
  end
end
