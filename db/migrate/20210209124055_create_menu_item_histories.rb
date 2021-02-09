class CreateMenuItemHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :menu_item_histories do |t|
      t.bigint :menu_id
      t.bigint :item_id
      t.decimal :price
      t.datetime :data_updated_at
      # This is not the current row updation, but is a reflection from the menu_items table
    end
  end
end
