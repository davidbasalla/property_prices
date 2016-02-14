class SalesController < ApplicationController
  helper_method :postcodes, :start_date, :end_date, :frequency

  def index
    if time_format_monthly?
      @sales_by_time_group = sales.group_by { |s| s.date.beginning_of_month }
    elsif time_format_weekly?
      @sales_by_time_group = sales.group_by { |s| s.date.beginning_of_week }
    elsif time_format_yearly?
      @sales_by_time_group = sales.group_by { |s| s.date.beginning_of_year }
    end
    @ticks = @sales_by_time_group.keys
    @sales = average_sales
    @total_sales =  number_of_sales
  end

  def sales
    Sale.time_frame(start_date, end_date).property_types(property_type_params).in_postcodes(postcodes).order(:date)
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

    params[:search_postcode].split(",")
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
    frequency == "Monthly"
  end

  def time_format_weekly?
    frequency == "Weekly"
  end

  def time_format_yearly?
    frequency == "Yearly"
  end

  def start_date
    params[:start_date].present? ? params[:start_date] : "2015-01-01"
  end

  def end_date
    params[:end_date].present? ? params[:end_date] : "2015-12-31"
  end

  def frequency
    params[:select_frequency].present? ? params[:select_frequency] : "Monthly"
  end
end
