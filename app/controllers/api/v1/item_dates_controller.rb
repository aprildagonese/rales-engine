class Api::V1::ItemDatesController < ApplicationController
  def show
    item = Item.find(params[:id])
    day = item.best_day
    render json: ItemDateSerializer.new(BestDay.new(day))
  end
end
