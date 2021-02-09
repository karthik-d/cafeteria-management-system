class CreateMenuItems < ActiveRecord::Migration[6.1]
  def change
    create_table :menu_items do |t|
      t.bigint :menu_id
      t.bigint :item_id
      t.decimal :price
      t.datetime :updated_at, :default => DateTime.now
      t.datetime :archived_at, :default => nil
    end
  end
end
