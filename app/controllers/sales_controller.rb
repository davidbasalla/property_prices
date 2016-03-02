class SalesController < ApplicationController
  helper_method :postcodes, :start_date, :end_date, :frequency, :property_type_params

  def index
    @sales = sales
  end

  def graph
    @frequency = params[:frequency] || "weekly"

    sales_by_time_group

    @ticks = @sales_by_time_group.keys
    @sales = average_sales
    @total_sales = number_of_sales
    @counts = counts.map { |c| c * count_multiplier }
  end

  def sales_by_time_group
    if time_format_monthly?
      @sales_by_time_group = sales.group_by { |s| s.date.beginning_of_month }
    elsif time_format_weekly?
      @sales_by_time_group = sales.group_by { |s| s.date.beginning_of_week }
    elsif time_format_yearly?
      @sales_by_time_group = sales.group_by { |s| s.date.beginning_of_year }
    end
  end

  def sales
    Sale.time_frame(start_date, end_date)
        .property_types(property_type_params)
        .in_postcodes(postcodes)
        .in_street(params[:search_street])
        .order(:date)
  end

  def average_sales
    @_sales ||= @sales_by_time_group.map do | start_of_time, sales_of_time_group |
      sum = sales_of_time_group.sum { |s| s.amount }
      average = sum/sales_of_time_group.count
    end
  end

  def counts
    @_counts ||= @sales_by_time_group.map do | _, sales_of_time_group |
      sales_of_time_group.count
    end
  end

  def count_multiplier
    @_count_mult ||= average_sales.min / counts.max
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
    types << "flats" if params["flats"]
    types << "detached" if params["detached"]
    types << "semi_detached" if params["semi_detached"]
    types << "terraced" if params["terraced"]
    types.empty? ? ["flats"] : types
  end

  def time_format_monthly?
    @frequency == "monthly"
  end

  def time_format_weekly?
    @frequency == "weekly"
  end

  def time_format_yearly?
    @frequency == "yearly"
  end

  def start_date
    params[:start_date].present? ? params[:start_date] : "2015-09-01"
  end

  def end_date
    params[:end_date].present? ? params[:end_date] : "2015-12-31"
  end

  def frequency
    params[:select_frequency].present? ? params[:select_frequency] : "Monthly"
  end
end
