class MenusController < ApplicationController
  helper_method :selected_items,
                :non_selected_items,
                :non_added_non_selected_items

  def index
    render "index"
  end

  def new
    if !session[:create_menu_items_selection]
      session[:create_menu_items_selection] = Hash({})
    end
    render "new"
  end

  def show
    if !session[:update_menu_items_selection]
      session[:update_menu_items_selection] = Hash({})
    end
    menu = Menu.find_by(id: params[:id])
    if (menu)
      @menu = menu
      render "show"
    else
      redirect_to menus_path
    end

  end

  def create
    # POST /menus
    menu = Menu.new(name: params[:name])
    if (!menu.save)
      helpers.add_error_flash(menu.errors.full_messages)
      redirect_to new_menu_path
    else
      # Create and link menu items
      has_failed = false

      if(params[:items])
        params[:items].each do |item_id, item_price|
          menu_item = MenuItem.new(item_id: item_id.to_i,
                                   menu_id: menu.id,
                                   price: item_price)
          if (!menu_item.save)
            has_failed = true
            session[:create_menu_items_selection].reject! { |key| key == item_id }
          end
        end
        helpers.add_info_flash("New category '#{menu.name}' created")
      else
        helpers.add_info_flash("New category '#{menu.name}'created. Currently empty")
      end

      if has_failed
        helpers.add_error_flash("Some items could not be added. Price was empty")
      end
      redirect_to menus_path
    end
  end

  def update
    # PUT /menus/:id
    menu = Menu.find_by(id: params[:id])
    if (menu)
      old_name = menu.name
      menu.name = params[:name]
      if(!menu.save)
        helpers.add_error_flash(menu.errors.full_messages)
        redirect_back(fallback_location: root_path)
      else
        # Create and link menu items
        if(old_name!=menu.name)
          helpers.add_info_flash("Category '#{old_name}' renamed to '#{menu.name}'")
        end

        has_failed = false
        if(params[:items])
          params[:items].each do |item_id, item_price|
            menu_item = MenuItem.new(item_id: item_id.to_i,
                                     menu_id: menu.id,
                                     price: item_price)
            if (!menu_item.save)
              has_failed = true
            else
              session[:update_menu_items_selection].reject! { |key| key == item_id }
            end
          end
          helpers.add_info_flash("Category '#{menu.name}' updated")
        end

        if has_failed
          helpers.add_error_flash("Some items could not be added. Price was empty")
          redirect_back(fallback_location: root_path)
        else
          redirect_to menus_path
        end
      end
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def activate
    # PUT /menus/activate/:id
    menu = Menu.find_by(id: params[:id])
    if (menu)
      menu.is_active = !menu.is_active
      menu.save
    end
    redirect_to menus_path
  end

  def destroy
    # DELETE /menus/:id
    menu = Menu.find_by(id: params[:id])
    if(menu)
      name = menu.name
      menu.destroy
    end
    helpers.add_info_flash("Category '#{name}' deleted")
    redirect_to menus_path
  end

  def selected_items(session_key)
    if(session[session_key])
      session[session_key]
    else
      {}
    end
  end

  def non_selected_items(session_key)
    items = Item.not_in_selection(session[session_key])
  end

  def non_added_non_selected_items(session_key)
  # Items not in Menu and not in selection
    items = non_selected_items(session_key).not_in_records(@menu.menu_item.select(:item_id))
  end
end
