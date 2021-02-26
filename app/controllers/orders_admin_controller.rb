class OrdersAdminController < ApplicationController

  def index
    @orders = Order.order(created_at: :DESC)
    render "index"
  end

  def search
    # POST /orders/search
    start_date = params[:start_date]
    end_date = params[:end_date]
    query = params[:search_query]
    status = params[:status] ? params[:status] : :all
    users = User.search(query)
    @orders = Order.after(start_date).
                    upto(end_date).
                    of_users(users).
                    send(status.to_sym).
                    order(created_at: :DESC)
    @start_date = start_date
    @end_date = end_date
    @search_query = query
    @status = status
    render "index"
  end

  def create
    order = Order.new(
      user_id: current_user.id,
      total_price: params[:total_price],
    )
    cart_items = current_user.cart_item.active_now
    # As an improvement, report items that may have expired during this step
    if (!cart_items)
      helpers.add_error_flash("Cart is empty")
    elsif (!order.save)
      helpers.add_error_flash(order.errors.full_messages)
    else
      # Create order items
      has_error = false
      cart_items.each do |c_item|
        order_item = OrderItem.new(
          order_id: order.id,
          menu_item_id: c_item.menu_item.id,
          quantity: c_item.quantity,
        )
        if (!order_item.save)
          has_error = true
          next
        else
          c_item.destroy
        end
      end

      if (has_error)
        helpers.add_error_flash("Some item(s) could not be ordered. Please try later")
      end
      helpers.add_info_flash("Your order has been placed!")
      redirect_to order_path(order.id)
    end
  end

  def show
    order = Order.find_by(id: params[:id])
    if(order)
      @order = order
      @order_items = @order.order_item
      render "show"
    else
      redirect_to orders_path
    end
  end

  def update
    order = Order.find_by(id: params[:id])
    if (order)
      order.delivered_at = Time.now
      order.delivered_by = current_user.id
      order.save
    end
    redirect_to list_orders_path
  end

  def destroy
    order = Order.find_by(id: params[:id])
    if (order)
      order.archived_at = Time.now
      order.archived_by = current_user.id
      order.save
    end
    redirect_to list_orders_path
  end
end
