class Order < ApplicationRecord
    has_many :order_item
    belongs_to :user

    def placement_time
        created_at.to_s(:short)
    end

    def self.pending
        all.where(delivered_at: nil).where(archived_at: nil)
    end

    def self.handled
        # Cannot cancel order after delivery!
        # Either delivered or archived
        all.where.not(delivered_at: nil).or(all.where.not(archived_at: nil))
    end
end
