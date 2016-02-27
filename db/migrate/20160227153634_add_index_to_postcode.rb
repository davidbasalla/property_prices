class AddIndexToPostcode < ActiveRecord::Migration
  def change
    add_index :sales, :postcode, :name => 'postcode_ix'
    add_index :sales, :date, :name => 'date_ix'
    add_index :sales, :property_type, :name => 'prop_type_ix'
  end
end
