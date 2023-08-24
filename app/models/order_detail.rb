class OrderDetail < ApplicationRecord
  belongs_to:order
  belongs_to:item

  def add_tax_price
    (price * 1.1).floor
  end

  def sub_total
    (price * amount * 1.1).floor
  end


  enum making_status: {impossible: 0, waiting_for_production: 1, under_construction: 2, production_completed: 3 }
end
