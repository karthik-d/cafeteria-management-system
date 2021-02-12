class CartItemsController < ApplicationController

    def index
        cart = current_user.cart_item
        @expired_items = cart.inactive_now.order(:created_at)
        @cart_items = cart.active_now.order(:created_at)
        if(@cart_items)
            @total_price = @cart_items.reduce(0) { |total, item| total+=item.menu_item.price*item.quantity }.to_i
        else
            @total_price = 0
        end
        render "index"
    end

    def new
        menu = Menu.active_menu
        if(menu)
            @menu_items = menu.menu_item
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
        redirect_back fallback_location: new_cart_item_path
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
        redirect_back fallback_location: new_cart_item_path
    end

    def destroy
        cart_item = current_user.cart_item.find_by(id: params[:id])
        if(cart_item)
            cart_item.destroy
        end
        redirect_back fallback_location: new_cart_item_path
    end

end
