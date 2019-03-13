class Api::V1::ItemDatesController < ApplicationController
  def show
    item = Item.find(params[:item_id])
    day = item.best_day.first
    render json: ItemDateSerializer.new(day)
  end
end
