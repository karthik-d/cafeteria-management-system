class OrdersAdminController < ApplicationController

    def index
    @orders = Order.order(created_at: :DESC)
        render "index"
    end

    def update
        order = Order.find_by(id: params[:id])
        if(order)
            order.delivered_at = Time.now
            order.delivered_by = current_user.id
            order.save
        end
        redirect_to list_orders_path
    end

    def destroy
        order = Order.find_by(id: params[:id])
        if(order)
            order.archived_at = Time.now
            order.archived_by = current_user.id
            order.save
        end
        redirect_to list_orders_path
    end
end