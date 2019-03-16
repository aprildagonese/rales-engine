class Api::V1::TransactionsController < ApplicationController
 def index
   transactions = Transaction.all
   render json: TransactionSerializer.new(transactions)
 end

 def show
   transaction = Transaction.find(params[:id])
   render json: TransactionSerializer.new(transaction)
 end
end
