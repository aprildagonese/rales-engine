class Api::V1::InvoiceitemsController < ApplicationController
 def index
   invoiceitems = InvoiceItem.all
   render json: InvoiceItemSerializer.new(invoiceitems)
 end

 def show
   invoiceitem = InvoiceItem.find(params[:id])
   render json: InvoiceItemSerializer.new(invoiceitem)
 end
end
