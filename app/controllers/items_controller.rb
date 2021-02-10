class ItemsController < ApplicationController

    def index
        render "index"
    end

    def create
        # POST /items
        item = Item.new(
            name: params[:name],
            description: params[:description],
            diet_type: params[:diet_type]
        )
        if(item.save)
            if(params[:source]=="new_menu_path")
                session[:create_menu_items_selection][item.id.to_s] = item
                redirect_to new_menu_path
            else
                redirect_to items
            end
        end
    end

    def select
        # POST /items/select
        params[:item_id].each do |id|
            item = Item.find_by(id: id)
            if(item)
                session[:create_menu_items_selection][item.id.to_s] = item
            end
        end
        redirect_to new_menu_path
    end
end
