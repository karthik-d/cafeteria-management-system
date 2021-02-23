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

        if(params[:source]=="new_menu_path")
            session_key = :create_menu_items_selection
        elsif(params[:source]=="update_menu_path")
            session_key = :update_menu_items_selection
        else
          # Tampered values
          redirect_back(fallback_location: root_path)
          return
        end

        if(item.save)
            session[session_key][item.id.to_s] = item
            helpers.add_info_flash("New item created")
        else
            helpers.add_error_flash(item.errors.full_messages)
        end

        redirect_back(fallback_location: root_path)
    end

    def select
        # POST /items/select
        if(params[:source]=="new_menu_path")
            session_key = :create_menu_items_selection
        elsif(params[:source]=="update_menu_path")
            session_key = :update_menu_items_selection
        else
          # Tampered values
          redirect_back(fallback_location: root_path)
          return
        end

        params[:item_id].each do |id|
            item = Item.find_by(id: id)
            if(item)
                session[session_key][item.id.to_s] = item
            end
        end

        redirect_back(fallback_location: root_path)
    end

    def unselect
      # DELETE /items/unselect/:id
      if(params[:source]=="new_menu_path")
          session[:create_menu_items_selection].reject! { |key| key == params[:id] }
      elsif(params[:source]=="update_menu_path")
          session[:update_menu_items_selection].reject! { |key| key == params[:id] }
      end
      redirect_back(fallback_location: root_path)
    end
end
