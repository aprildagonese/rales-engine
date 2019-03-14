class Api::V1::CustomersController < ApplicationController
 def index
   customers = Customer.all
   render json: CustomerSerializer.new(customers)
 end

 def show
   customer = Customer.find(params[:id])
   render json: CustomerSerializer.new(customer)
 end
end
