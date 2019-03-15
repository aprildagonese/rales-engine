class RevenueSerializer
  include FastJsonapi::ObjectSerializer
  attributes :total_revenue, :id
  set_id :id

end
