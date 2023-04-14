class Admin::OrderDetailsController < ApplicationController

  def update
    @order_detail = Order_detail.find(params[:id])
    @order_detail.update(order_detail_params)
    redirect_to admin_order_path
  end

  private

  def order_detail
    params.require(:order_detail).permit(:making_status)
  end
end
