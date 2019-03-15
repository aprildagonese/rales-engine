class Revenue
  attr_reader :total_revenue, :id

  def initialize(revenue)
    @total_revenue = revenue
    @id = 1
  end
end
