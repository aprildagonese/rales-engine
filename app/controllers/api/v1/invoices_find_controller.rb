class Api::V1::InvoicesFindController < ApplicationController

  def index
    if params[:id]
      @invoices = Invoice.where(id: params[:id])
    elsif params[:customer_id]
      @invoices = Invoice.where(customer_id: params[:customer_id])
    elsif params[:merchant_id]
      @invoices = Invoice.where(merchant_id: params[:merchant_id])
    elsif params[:status]
      @invoices = Invoice.where(status: params[:status])
    elsif params[:created_at]
      @invoices = Invoice.where(created_at: params[:created_at])
    elsif params[:updated_at]
      @invoices = Invoice.where(updated_at: params[:updated_at])
    end
    render json: InvoiceSerializer.new(@invoices)
  end

  def show
    if params[:id]
      @invoice = Invoice.find(params[:id])
    elsif params[:customer_id]
      @invoice = Invoice.find_by(customer_id: params[:customer_id])
    elsif params[:merchant_id]
      @invoice = Invoice.find_by(merchant_id: params[:merchant_id])
    elsif params[:status]
      @invoice = Invoice.find_by(status: params[:status])
    elsif params[:created_at]
      @invoice = Invoice.find_by(created_at: params[:created_at])
    elsif params[:updated_at]
      @invoice = Invoice.find_by(updated_at: params[:updated_at])
    end
    render json: InvoiceSerializer.new(@invoice)
  end

end
