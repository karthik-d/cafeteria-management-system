class MenuItemsController < ApplicationController

    def index
        render "index"
    end

    def create
    end

    def destroy
      # DELETE /menu_items/:id
      menu_item = MenuItem.find_by(id: params[:id])
      if(menu_item)
        menu_item.destroy
        helpers.add_info_flash("Item removed from category")
      end
      redirect_back(fallback_location: root_path)
    end
end
