class Sale < ActiveRecord::Base

  scope :detached, -> { where(property_type: "D") }
  scope :semi_detached, -> { where(property_type: "S") }
  scope :terraced, -> { where(property_type: "T") }
  scope :flats, -> { where(property_type: "F") }
  scope :other, -> { where(property_type: "O") }

  def self.average_amount(sales)
    sales.map { |s| s.amount }
  end

  def self.property_types(property_types)
    Sale.where(property_types_where_values(property_types).join(" OR "))
  end

  def self.property_types_where_values(property_types)
    property_types.map { |p| property_type_where_value(p) }
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

  def self.in_postcodes(postcodes)
    Sale.where(postcode_where_values(postcodes).join(" OR "))
  end

  def self.postcode_where_values(postcodes)
    postcodes.map { |p| postcode_where_value(p) }
  end

  def self.postcode_where_value(postcode)
    "postcode ~* '^#{postcode}[^a-zA-Z].*'"
  end
end
