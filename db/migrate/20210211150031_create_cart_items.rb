class CreateCartItems < ActiveRecord::Migration[6.1]
  def change
    create_table :cart_items do |t|
      t.bigint :user_id
      t.bigint :menu_item_id
      t.integer :quantity, :default => 1
      t.timestamps
    end
  end
end
