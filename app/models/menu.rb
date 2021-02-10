class Menu < ApplicationRecord
  has_many :menu_items
  validates :name, presence: true, length: { minimum: 4 }

  def self.active_menus
      all.where(is_active: true)
  end

  def self.deactivate_all
      active_menus.each do |menu|
          menu.is_active = false;
          menu.save
      end
  end
end
