class ItemDateSerializer
  include FastJsonapi::ObjectSerializer
  attributes :created_at
end
