class CreateMenus < ActiveRecord::Migration[6.1]
  def change
    create_table :menus do |t|
      t.string :name
      t.boolean :is_active, :default => false
      t.timestamps
    end
  end
end
