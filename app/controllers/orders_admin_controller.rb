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
    status = params[:status]
    users = User.search(query)
    @orders = Order.after(start_date).
                    upto(end_date).
                    of_users(users).
                    send(status).
                    order(created_at: :DESC)
    @start_date = start_date
    @end_date = end_date
    @search_query = query
    @status = status
    render "index"
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
