class ItemDateSerializer
  include FastJsonapi::ObjectSerializer
  set_id :id
  attribute :best_day do |object|
    object.best_day.to_date.to_s
  end
end
