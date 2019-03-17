class Api::V1::InvoiceitemsInvoiceController < ApplicationController
  def show
    invoiceitem = InvoiceItem.find(params[:id])
    invoice = invoiceitem.invoice
    render json: InvoiceSerializer.new(invoice)
  end
end
