class SalesController < ApplicationController
  helper_method :postcode

  def index
    if time_format_monthly?
      @sales_by_time_group = sales.group_by { |s| s.date.beginning_of_month }

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

  def sales
    Sale.property_types(property_type_params).in_postcode(postcode).order(:date)
  end

  def postcode
    params[:search_postcode] || "N1"
  end

  def property_type_params
    types = []
    types << "flats" if params["toggle_flats"]
    types << "detached" if params["toggle_detached"]
    types << "semi_detached" if params["toggle_semi_detached"]
    types << "terraced" if params["toggle_terraced"]
    types
  end

  def time_format_monthly?
    true
  end

  def time_format_weekly?
    false
  end
end
