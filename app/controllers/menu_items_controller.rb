class MenuItemsController < ApplicationController

    def index
        render "index"
    end

    def create
    end

    def destroy
      # DELETE /menu_items/:id
      menu_item = MenuItem.find_by(id: params[:id])
      name = menu_item.item.name
      if(menu_item)
        menu_item.destroy
        helpers.add_info_flash("Item '#{name}' removed from category")
      end
      redirect_back(fallback_location: root_path)
    end
end
