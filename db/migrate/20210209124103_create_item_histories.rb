class CreateItemHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :item_histories do |t|
      t.bigint :item_id
      t.string :name
      t.string :description
      t.string :diet_type
      t.datetime :data_updated_at
      # This is not the current row updation, but is a reflection from the items table
    end
  end
end
