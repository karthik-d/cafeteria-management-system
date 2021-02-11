class Item < ApplicationRecord
    has_many :menu_items  # It can belong to multiple menus, indirectly    
    validates :name, presence: true, length: {minimum: 4}, uniqueness: true
    validates :diet_type, presence: true
    validates_inclusion_of :diet_type, :in => %w(veg egg nonveg)

    def self.not_selected_for_new_menu(selected_items)
        selected_ids = selected_items.keys.map(&:to_i)
        Item.all.filter{ |item| !selected_ids.include?(item.id) }
    end

end
