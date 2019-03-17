class Api::V1::InvoiceitemsFindController < ApplicationController

  def index
    if params[:id]
      @invoiceitems = InvoiceItem.where(id: params[:id])
    elsif params[:item_id]
      @invoiceitems = InvoiceItem.where(item_id: params[:item_id])
    elsif params[:invoice_id]
      @invoiceitems = InvoiceItem.where(invoice_id: params[:invoice_id])
    elsif params[:quantity]
      @invoiceitems = InvoiceItem.where(quantity: params[:quantity])
    elsif params[:unit_price]
      @invoiceitems = InvoiceItem.where(unit_price: params[:unit_price])
    elsif params[:created_at]
      @invoiceitems = InvoiceItem.where(created_at: params[:created_at])
    elsif params[:updated_at]
      @invoiceitems = InvoiceItem.where(updated_at: params[:updated_at])
    end
    render json: InvoiceItemSerializer.new(@invoiceitems)
  end

  def show
    if params[:id]
      @invoiceitem = InvoiceItem.find(params[:id])
    elsif params[:item_id]
      @invoiceitem = InvoiceItem.find_by(item_id: params[:item_id])
    elsif params[:invoice_id]
      @invoiceitem = InvoiceItem.find_by(invoice_id: params[:invoice_id])
    elsif params[:quantity]
      @invoiceitem = InvoiceItem.find_by(quantity: params[:quantity])
    elsif params[:unit_price]
      @invoiceitem = InvoiceItem.find_by(unit_price: params[:unit_price])
    elsif params[:created_at]
      @invoiceitem = InvoiceItem.find_by(created_at: params[:created_at])
    elsif params[:updated_at]
      @invoiceitem = InvoiceItem.find_by(updated_at: params[:updated_at])
    end
    render json: InvoiceItemSerializer.new(@invoiceitem)
  end

end
