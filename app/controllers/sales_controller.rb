class SalesController < ApplicationController
  def index
    @postcode = "NW6"

    @sales_by_month = Sale.in_postcode(@postcode).flats.order(:date).group_by { |s| s.date.beginning_of_month }

    sales = @sales_by_month.map do | start_of_month, sales_of_month |
      sum = sales_of_month.sum { |s| s.amount }
      average = sum/sales_of_month.count
    end

    @total_sales = @sales_by_month.sum { |k, v| v.count }
    @sales = sales
    @ticks = Array(1..12)
  end
end
