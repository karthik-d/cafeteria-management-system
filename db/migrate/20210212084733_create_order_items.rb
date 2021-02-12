class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|
        t.bigint :order_id
        t.bigint :menu_item_id
        t.integer :quantity
        t.datetime :archived_at, :default => nil
        # creation time is same as the order's
    end
  end
end
