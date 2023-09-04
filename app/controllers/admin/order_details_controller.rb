class Admin::OrderDetailsController < ApplicationController

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    @order_details = @order.order_details.all
    @order_detail.update(order_detail_params)

  if @order_details.where(making_status: "under_construction").count >= 1
      @order.status = "in_production"
      @order.save

  elsif @order.order_details.count == @order_details.where(making_status: "production_completed").count
    @order.status = "preparing_delivery"
    @order.save
  end
    redirect_to admin_order_path(@order.id)
  end

  # if @order.order_details.any?{ |mstatus| mstatus.making_status == "under_construction" }
  #   @order.status = "in_production"
  #   @order.save
  # elsif @order.order_details(:making_status).distinct.count == 1
  #   @order.status = "preparing_delivery"
  #   @order.save
  # end
  # 　admin_order_path(@order)
  # end


  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
