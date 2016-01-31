class Sale < ActiveRecord::Base

  scope :detached, -> { where(property_type: "D") }
  scope :semi_detached, -> { where(property_type: "S") }
  scope :terraced, -> { where(property_type: "T") }
  scope :flats, -> { where(property_type: "F") }
  scope :other, -> { where(property_type: "O") }
  scope :in_postcode, ->(postcode) { where("postcode ILIKE ?", "#{postcode}%") }

  def self.average_amount(sales)
    sales.map { |s| s.amount }
  end

  def self.property_types(params)
    Sale.where(property_types_where_values(params).join(" OR "))
  end

  def self.property_types_where_values(params)
    Sale.send_chained_where_values(params).where_values
  end

  def self.send_chained_where_values(arr)
    arr.inject(self) {|o, a| o.send(:where, property_type_where_value(a)) }
  end

  def self.property_type_where_value(arg)
    case arg
    when "flats"
      "property_type='F'"
    when "terraced"
      "property_type='T'"
    when "semi_detached"
      "property_type='S'"
    when "detached"
      "property_type='D'"
    when "other"
      "property_type='O'"
    end
  end
end
