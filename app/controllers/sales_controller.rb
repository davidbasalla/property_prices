class SalesController < ApplicationController
  def index
    @postcode = postcode

    if time_format_monthly?
      @sales_by_time_group = Sale.in_postcode(@postcode).flats.order(:date).group_by { |s| s.date.beginning_of_month }

      @sales = @sales_by_time_group.map do | start_of_month, sales_of_month |
        sum = sales_of_month.sum { |s| s.amount }
        average = sum/sales_of_month.count
      end

      @total_sales = @sales_by_time_group.sum { |k, v| v.count }
      @ticks = Array(1..12).map { |n| Date::MONTHNAMES[n] }
    elsif time_format_weekly?
      @sales_by_time_group = Sale.in_postcode(@postcode).flats.order(:date).group_by { |s| s.date.beginning_of_week }

      @sales = @sales_by_time_group.map do | start_of_month, sales_of_month |
        sum = sales_of_month.sum { |s| s.amount }
        average = sum/sales_of_month.count
      end

      @total_sales = @sales_by_time_group.sum { |k, v| v.count }
      @ticks = @sales_by_time_group.keys
    end
  end

  def postcode
    params[:search_postcode] || "N1"
  end

  def time_format_monthly?
    true
  end

  def time_format_weekly?
    false
  end
end
