class CartItem < ApplicationRecord

    belongs_to :menu_item
    belongs_to :user
    validates :quantity, numericality: { only_integer: true, greater_than: 0 }

    def is_active?
        menu_item.menus.where(is_active: true)>0 ? true : false
    end
end
