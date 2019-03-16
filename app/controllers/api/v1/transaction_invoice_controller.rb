class Api::V1::TransactionInvoiceController < ApplicationController
  def show
    transaction = Transaction.find(params[:id])
    invoice = transaction.invoice
    render json: InvoiceSerializer.new(invoice)
  end
end
