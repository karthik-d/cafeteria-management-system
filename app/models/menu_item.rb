class MenuItem < ApplicationRecord
    belongs_to :menu
    belongs_to :item
    has_many :cart_item
    has_many :order_item
    validates :menu_id, presence: true
    validates :item_id, presence: true
    validates :price, numericality: {greater_than: 0}    # numericality doesn't allow nil

    def cart_id_for_user(current_user)
        item = cart_item.find_by(user_id: current_user.id)
        if(item)
            item.id
        else
            false
        end
    end

    def quantity_for_user(current_user)
        item = cart_item.find_by(user_id: current_user.id)
        if(item)
            item.quantity
        else
            0
        end
    end

    def self.active_menu_items
        all.where(menu_id: Menu.active_menus.ids)
    end

    def self.active_menu_item_ids
        all.where(menu_id: Menu.active_menus.ids).ids
    end
end
