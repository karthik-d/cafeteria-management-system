class Item < ApplicationRecord
    has_many :menu_items  # It can belong to multiple menus, indirectly
    validates_inclusion_of :diet_type, :in => %w(veg egg nonveg)

    def self.not_selected_for_new_menu(selected_items)
        puts "hello"
        selected_ids = selected_items.map { |item| item["id"] }
        Item.all.filter{ |item| !selected_ids.include?(item.id) }
    end

end
