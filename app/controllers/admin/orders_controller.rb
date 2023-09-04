class Admin::OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @total = 0
  end

  def update
    @orders = Order.find(params[:id])
    @orders.update(order_params)
    @order_details = @orders.order_details.all
    if @orders.status == 'payment_confirmation'
      @order_details.each do |order_details|
        order_details.making_status = 'waiting_for_production'
        order_details.save
      end

    end
    redirect_to admin_order_path
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end
end
