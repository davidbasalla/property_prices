require "uk_postcode"

class Sale < ActiveRecord::Base

  scope :detached, -> { where(property_type: "D") }
  scope :semi_detached, -> { where(property_type: "S") }
  scope :terraced, -> { where(property_type: "T") }
  scope :flats, -> { where(property_type: "F") }
  scope :other, -> { where(property_type: "O") }
  scope :time_frame, -> (start_date, end_date) { where("date >= '#{start_date}' AND date <= '#{end_date}'") }
  scope :in_street, -> (street){ where("street ILIKE '%#{street}%'")}

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
    pc = UKPostcode.parse(postcode)

    if pc.full?
      "postcode = '#{postcode}'"
    elsif pc.area && pc.district && pc.sector
      "postcode ~* '^#{postcode}[^0-9].*'"
    elsif pc.area && pc.district
      "postcode ~* '^#{postcode} .*'"
    elsif pc.area
      "postcode ~* '^#{postcode}[^a-zA-Z].*'"
    end
  end
end
