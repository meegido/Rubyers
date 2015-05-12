class AddPlaceToDirections < ActiveRecord::Migration
  def change
  	add_column :directions, :place, :string
  end
end
