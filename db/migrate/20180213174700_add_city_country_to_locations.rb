class AddCityCountryToLocations < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :city, :string, :after => :google_address
    add_column :locations, :country, :string, :after => :city
  end
end
