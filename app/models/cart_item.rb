class CartItem < ApplicationRecord

    belongs_to :menu_item
    belongs_to :user
    validates :quantity, numericality: { only_integer: true, greater_than: 0 }

    def is_active?
        menu_item.menus.where(is_active: true)>0 ? true : false
    end

    def self.active_now
        all.where('menu_item_id IN (?)', MenuItem.active_menu_item_ids)
    end

    def self.inactive_now
        all.where('menu_item_id NOT IN (?)', MenuItem.active_menu_item_ids)
    end
end
