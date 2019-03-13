class Api::V1::ItemFindController < ApplicationController
  def index
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
  end
  render json: ItemSerializer.new(@item)
end
