class MenusController < ApplicationController
  helper_method :selected_items, :non_selected_items

  def index
    render "index"
  end

  def new
    if !session[:create_menu_items_selection]
      session[:create_menu_items_selection] = Hash({})
    end
    render "new"
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
        params[:items].each do |item_id, item_price|
          menu_item = MenuItem.new(item_id: item_id.to_i,
                                   menu_id: menu.id,
                                   price: item_price)
          if (!menu_item.save)
            has_failed = true
          end
          session[:create_menu_items_selection].reject! { |key| key==item_id }
        end
        if has_failed
          helpers.add_error_flash("Some items could not be added. Price was empty")
          # REDIRECT TO MENU EDIT
        end

        helpers.add_info_flash("Menu created")
        redirect_to menus_path
    end
  end

  def update
      # UPDATE /menus/:id
      menu = Menu.find_by(id: params[:id])
      if(menu)
          menu.is_active = !menu.is_active;
          menu.save
      end
      redirect_to menus_path
  end

  def selected_items
    session[:create_menu_items_selection]
  end

  def non_selected_items
    Item.not_selected_for_new_menu(session[:create_menu_items_selection])
  end
end
