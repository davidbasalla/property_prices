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
end
