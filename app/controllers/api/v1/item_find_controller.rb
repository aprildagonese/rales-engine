class Api::V1::ItemFindController < ApplicationController

  def index
    if params[:id]
      @items = Item.where(id: params[:id]).order(:id)
    elsif params[:name]
      @items = Item.where(name: params[:name])
    elsif params[:description]
      @items = Item.where(description: params[:description])
    elsif params[:merchant_id]
      @items = Item.where(merchant_id: params[:merchant_id]).order(:id)
    elsif params[:unit_price]
      unit_price = ((params[:unit_price].to_f*100).round).to_s
      @items = Item.where(unit_price: unit_price)
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
    elsif params[:description]
      @item = Item.find_by(description: params[:description])
    elsif params[:merchant_id]
      @item = Item.where(merchant_id: params[:merchant_id]).order(:id).first
    elsif params[:unit_price]
      unit_price = ((params[:unit_price].to_f*100).round).to_s
      @item = Item.find_by(unit_price: unit_price)
    elsif params[:created_at]
      @item = Item.where(created_at: params[:created_at]).order(:id).first
    elsif params[:updated_at]
      @item = Item.where(updated_at: params[:updated_at]).order(:id).first
    end
    render json: ItemSerializer.new(@item)
  end

end
