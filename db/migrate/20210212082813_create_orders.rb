class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
        t.bigint :user_id
        t.decimal :total_price
        t.datetime :created_at, :default => DateTime.now
        t.datetime :archived_at, :default => nil
        t.datetime :delivered_at, :default => nil
    end
  end
end
