class RevenueSerializer
  include FastJsonapi::ObjectSerializer
  set_id :id
  attribute :revenue do |object|
    '%.2f' % (object.revenue / 100.0)
  end

end
