require "csv"

class Importer
  attr_reader :filename, :klass

  def initialize(klass, filename)
    @filename = filename
    @klass = klass
  end

  def import
    entries.each do |e|
      klass.new(e).save
    end
  end

  def entries
    @_entries ||= values.map do |v|
      headers.zip(v).to_h
    end
  end

  def headers
    [
      "uuid",
      "amount",
      "date",
      "postcode",
      "property_type",
      "old_new",
      "duration",
      "paon",
      "saon",
      "street",
      "locality",
      "town_city",
      "district",
      "county",
      "ppd_category_type",
      "record_status"
    ]
  end

  def values
    @_arr_of_arrs ||= CSV.read(filename)
  end
end
