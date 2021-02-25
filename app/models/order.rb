class Order < ApplicationRecord
    has_many :order_item
    belongs_to :user

    def placement_time
        created_at.to_s(:short)
    end

    def cancelled?
      archived_at==nil ? false : true
    end

    def delivered?
      delivered_at==nil ? false : true
    end

    def pending?
      !delivered? && !cancelled?
    end

    def handle_user
      if(cancelled?)
        # Could also be deleted by a deleted user
        User.find(archived_by)
      elsif(delivered?)
        User.find(delivered_by)
      end
    end

    def handle_date
      if(cancelled?)
        archived_at.to_date.to_s(:long)
      elsif(delivered?)
        delivered_at.to_date.to_s(:long)
      end
    end

    def handle_time
      if(cancelled?)
        archived_at.to_s(:time)
      elsif(delivered?)
        delivered_at.to_s(:time)
      end
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
