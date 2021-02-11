class CartItemsController < ApplicationController

    def new
        menu = Menu.active_menus.first
        if(menu)
            @menu_items = menu.menu_items
            render "new"
        else
            @menu_items = nil
            redirect_to root_path
        end
    end

    def create
        cart_item = CartItem.new(
            user_id: current_user.id,
            menu_item_id: params[:menu_id],
            quantity: 1
        )
        if(!cart_item.save)
            helpers.add_info_flash(cart_item.errors.full_messages)
        end
        redirect_to new_cart_item_path
    end

    def update
        cart_item = current_user.cart_item.find_by(id: params[:id])
        if(cart_item)
            if(params[:change].eql?("add"))
                cart_item.quantity += 1
            elsif(params[:change].eql?("remove"))
                cart_item.quantity -= 1
            end

            if(cart_item.quantity==0)
                cart_item.destroy()
            elsif(!cart_item.save)
                helpers.add_info_flash(cart_item.errors.full_messages)
            end
        end
        redirect_to new_cart_item_path
    end

    def destroy
        cart_item = current_user.cart_item.find_by(id: params[:id])
        if(cart_item)
            cart_item.destroy
        end
        redirect_to new_cart_item_path
    end

end
