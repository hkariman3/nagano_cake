class Admin::HomesController < ApplicationController

  def top
   @top = Order.all
  end

  private

end