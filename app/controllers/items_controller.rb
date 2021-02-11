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
            session[:create_menu_items_selection][item.id.to_s] = item
            helpers.add_info_flash("New item created")
        else
            helpers.add_error_flash(item.errors.full_messages)
        end

        if(params[:source]=="new_menu_path")
            redirect_to new_menu_path
        else
            redirect_to items
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
