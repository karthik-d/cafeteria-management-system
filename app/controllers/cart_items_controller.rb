class CartItemsController < ApplicationController
  before_action :set_user

  def set_user
    if current_user.check_role("billing_clerk")
      @order_user = User.walkin_customer
    else
      @order_user = current_user
    end
  end

  def index
    cart = @order_user.cart_item
    @expired_items = cart.inactive_now.order(:created_at)
    @cart_items = cart.active_now.order(:created_at)
    if (@cart_items)
      @total_price = @cart_items.reduce(0) { |total, item| total += item.menu_item.price * item.quantity }.to_i
    else
      @total_price = 0
    end
    render "index"
  end

  def new
    # Must be changed to render category wise
    # categories = Menu.active_menus
    menus = Menu.active_menus.order(:name)

    cart = @order_user.cart_item
    @expired_items = cart.inactive_now.order(:created_at)
    @cart_items = cart.active_now.order(:created_at)
    if (@cart_items)
      @total_price = @cart_items.reduce(0) { |total, item| total += item.menu_item.price * item.quantity }.to_i
    else
      @total_price = 0
    end

    if(menus.empty?)
        @menus = nil
        helpers.add_info_flash("We are still cooking... Please come back later!")
        redirect_to root_path
    else
        @menus = menus
        render "new"
    end
  end

  def create
    cart_item = CartItem.new(
      user_id: @order_user.id,
      menu_item_id: params[:menu_id],
      quantity: 1,
    )
    if (!cart_item.save)
      helpers.add_info_flash(cart_item.errors.full_messages)
    end
    redirect_back fallback_location: new_cart_item_path
  end

  def update
    cart_item = @order_user.cart_item.find_by(id: params[:id])
    if (cart_item)
      if (params[:change].eql?("add"))
        cart_item.quantity += 1
      elsif (params[:change].eql?("remove"))
        cart_item.quantity -= 1
      end

      if (cart_item.quantity == 0)
        cart_item.destroy()
      elsif (!cart_item.save)
        helpers.add_info_flash(cart_item.errors.full_messages)
      end
    end
    redirect_back fallback_location: new_cart_item_path
  end

  def destroy
    cart_item = @order_user.cart_item.find_by(id: params[:id])
    if (cart_item)
      cart_item.destroy
    end
    redirect_back fallback_location: new_cart_item_path
  end
end
