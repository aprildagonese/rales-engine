class Api::V1::ItemsController < ApplicationController
  def index
    render json: Item.all
  end

  def show
    if params[:id] == "most_items"
      @items = Item.most_items(params[:quantity])
      render json: @items
    elsif params[:id] == "most_revenue"
      @items = Item.most_revenue(params[:quantity])
      render json: @items
    else
      render json: Item.find(params[:id])
    end
  end
end
