class ActiveMenusController < ApplicationController

    def show
        # Verify if requested menu is active
        menu = Menu.active_menus.find_by(id: params[:id])
        if(menu)
            @menu_items = menu.menu_items
            render "show"
        else
            @menu_items = nil
            redirect_to root_path
        end
    end
end
