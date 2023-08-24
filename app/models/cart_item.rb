class CartItem < ApplicationRecord
  belongs_to:item
  belongs_to:customer

  def sub_total
    (item.price * amount * 1.1).floor
  end
end
