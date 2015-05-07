class CreateDirections < ActiveRecord::Migration
  def change
    create_table :directions do |t|
      t.text :step
      t.string :gist
      t.belongs_to :post, index: true

      t.timestamps
    end
  end
end
