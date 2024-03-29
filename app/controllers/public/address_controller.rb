class Public::AddressController < ApplicationController

  def index
    @address = Address.new
    @address1 = current_customer
    @address2 = @address1.addresses
  end

  def edit
    @address = Address.find(params[:id])
  end

  def create
    address = Address.new(address_params)
    address.customer_id = current_customer.id
    address.save!
    redirect_to address_index_path
  end

  def update
    address = Address.find(params[:id])
    address.update(address_params)
    redirect_to address_index_path

  end

  def destroy
    address = Address.find(params[:id])
    address.destroy
    redirect_to address_index_path
  end

  private

  def address_params
    params.require(:address).permit(:name,:postal_code,:address)
  end

end
