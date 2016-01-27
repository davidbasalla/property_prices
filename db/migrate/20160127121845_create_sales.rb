class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.string :uuid
      t.integer :amount
      t.date :date
      t.string :postcode
      t.string :property_type
      t.string :old_new
      t.string :duration
      t.string :paon
      t.string :saon
      t.string :street
      t.string :locality
      t.string :town_city
      t.string :district
      t.string :county
      t.string :ppd_category_type
      t.string :record_status

      t.timestamps null: false
    end
  end
end
