class Item < ApplicationRecord
    has_many :menu_items  # It can belong to multiple menus, indirectly
    validates :name, presence: true, length: {minimum: 4}, uniqueness: true
    validates :diet_type, presence: true
    validates_inclusion_of :diet_type, :in => %w(veg egg nonveg)

    def self.not_in_selection(selected_items)
      # Selected items is a HASH in this case
      if(selected_items.empty?)
        all
      else
        selected_ids = selected_items.keys.map(&:to_i)
        all.where('id NOT IN (?)', selected_ids)
      end
    end

    def self.not_in_records(item_ids)
      # Records is a valid ActiveRecord relation
      if(item_ids)
        all.where('id NOT IN (?)', item_ids)
      else
        all
      end
    end
end
