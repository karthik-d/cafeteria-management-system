class MenuItem < ApplicationRecord
    belongs_to :menu
    belongs_to :item
    validates :menu_id, presence: true
    validates :item_id, presence: true
    validates :price, numericality: {greater_than: 0}    # numericality doesn't allow nil
end
