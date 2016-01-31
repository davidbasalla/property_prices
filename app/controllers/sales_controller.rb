class SalesController < ApplicationController
  helper_method :postcodes

  def index
    if time_format_monthly?
      @sales_by_time_group = sales.group_by { |s| s.date.beginning_of_month }
      @ticks = Array(1..12).map { |n| Date::MONTHNAMES[n] }
    elsif time_format_weekly?
      @sales_by_time_group = sales.group_by { |s| s.date.beginning_of_week }
      @ticks = @sales_by_time_group.keys
    end
    @sales = average_sales
    @total_sales =  number_of_sales
  end

  def sales
    Sale.property_types(property_type_params).in_postcodes(postcodes).order(:date)
  end

  def average_sales
    @sales_by_time_group.map do | start_of_time, sales_of_time_group |
      sum = sales_of_time_group.sum { |s| s.amount }
      average = sum/sales_of_time_group.count
    end
  end

  def number_of_sales
    @sales_by_time_group.sum { |k, v| v.count }
  end

  def postcodes
    return ["N1"] if params[:search_postcode].nil?

    params[:search_postcode].split(",").map { |p| p.gsub(/\s+/, "") }
  end

  def property_type_params
    types = []
    types << "flats" if params["toggle_flats"]
    types << "detached" if params["toggle_detached"]
    types << "semi_detached" if params["toggle_semi_detached"]
    types << "terraced" if params["toggle_terraced"]
    types.empty? ? ["flats"] : types
  end

  def time_format_monthly?
    return true if params["select_frequency"].nil?
    params["select_frequency"] == "Monthly"
  end

  def time_format_weekly?
    params["select_frequency"] == "Weekly"
  end
end
