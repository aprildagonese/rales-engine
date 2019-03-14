class Api::V1::ItemFindController < ApplicationController

  def index
    if params[:id]
      @items = Item.where(id: params[:id])
    elsif params[:name]
      @items = Item.where(name: params[:name])
    elsif params[:created_at]
      @items = Item.where(created_at: params[:created_at])
    elsif params[:updated_at]
      @items = Item.where(updated_at: params[:updated_at])
    end
    render json: ItemSerializer.new(@items)
  end

  def show
    if params[:id]
      @item = Item.find(params[:id])
    elsif params[:name]
      @item = Item.find_by(name: params[:name])
    elsif params[:created_at]
      @item = Item.find_by(created_at: params[:created_at])
    elsif params[:updated_at]
      @item = Item.find_by(updated_at: params[:updated_at])
    end
    render json: ItemSerializer.new(@item)
  end

end
