class Revenue
  attr_reader :total_revenue, :id, :revenue

  def initialize(revenue)
    @total_revenue = revenue
    @revenue = revenue
    @id = 1
  end
end
