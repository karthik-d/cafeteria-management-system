class MenusController < ApplicationController
    helper_method :selected_items, :non_selected_items

    def index
        render "index"
    end

    def new
        if !session[:create_menu_items_selection]
            session[:create_menu_items_selection] = Array([])
        end
        render "new"
    end

    def selected_items
        session[:create_menu_items_selection]
    end

    def non_selected_items
        Item.not_selected_for_new_menu(session[:create_menu_items_selection])
    end
end
