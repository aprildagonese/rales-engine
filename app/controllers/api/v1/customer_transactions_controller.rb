class Api::V1::CustomerTransactionsController < ApplicationController
  def index
    customer = Customer.find(params[:id])
    transactions = customer.transactions
    render json: TransactionSerializer.new(transactions)
  end
end
