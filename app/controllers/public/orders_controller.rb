class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
    @customer = current_customer
  end

  def confirm
    @order = Order.new(order_params)
    @items = current_customer.cart_items
    @order.shipping_cost = 800
    @total = 0

  if params[:order][:select_address] == "0"
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.name = current_customer.first_name + current_customer.last_name
    render'confirm'

  elsif params[:order][:select_address] == "1"
    @address = Address.find(params[:order][:address_id])
    @order.postal_code = @address.postal_code
    @order.address = @address.address
    @order.name = @address.name
    render'confirm'

  elsif params[:order][:select_address] == "2"
    @address = current_customer.address.new
    @address.name = params[:order][:name]
    @address.address = params[:order][:address]
    @address.postal_code = params[:order][:postal_code]
    @address.customer.id = current_customer.id
    if @address.save
    @order.postal_code = @address.postal_code
    @order.name = @address.name
    @order.address = @address.address
    else
    render'new'
    end
  end
  end


  def thanks
  end

  def create
      @order = Order.new(order_params)
      @cart_items = current_customer.cart_items
      @order.customer_id = current_customer.id
      @order.shipping_cost = 800
      @order.total_payment = @order.shipping_cost + @cart_items.sum(&:sub_total)
    if @order.save!
      @order_details = current_customer.cart_items
      @order_details.each do |cart_item|
      order_detail = OrderDetail.new
      order_detail.order_id = @order.id
      order_detail.price = cart_item.item.price
      order_detail.amount = cart_item.amount
      order_detail.item_id = cart_item.item_id
      order_detail.save!
    end
      @order_details.destroy_all
      redirect_to orders_thanks_path
    else
      render "new"
    end
  end

  def index
    @order = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_detail = @order.order_details.all
  end

  private

  def order_params
    params.require(:order).permit(:address,:name,:postal_code,:amount,:payment_method,:status,:postage)
  end

  def address_params
    params.require(:address).permit(:name,:posal_code,:address)
  end
end
