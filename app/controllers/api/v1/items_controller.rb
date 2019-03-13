class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    if params[:id] == "most_items"
      @items = Item.most_items(params[:quantity])
      render json: ItemSerializer.new(@items)
    elsif params[:id] == "most_revenue"
      @items = Item.most_revenue(params[:quantity])
      render json: ItemSerializer.new(@items)
    else
      render json: ItemSerializer.new(Item.find(params[:id]))
    end
  end
end
