class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
        t.bigint :user_id
        t.decimal :total_price
        t.datetime :created_at, default: -> { 'CURRENT_TIMESTAMP' }
        t.datetime :archived_at, :default => nil
        t.bigint :archived_by, :default => nil
        # Deleted by user_id (to identify if customer or admin deleted)
        t.datetime :delivered_at, :default => nil
        t.bigint :delivered_by, :default => nil
        # User ID of user who marked as delivered
    end
  end
end
