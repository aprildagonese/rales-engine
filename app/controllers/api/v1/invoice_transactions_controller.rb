class Api::V1::InvoiceTransactionsController < ApplicationController
  def index
    invoice = Invoice.find(params[:id])
    transactions = invoice.transactions
    render json: TransactionSerializer.new(transactions)
  end
end
