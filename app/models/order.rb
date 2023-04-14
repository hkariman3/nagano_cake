class Order < ApplicationRecord

  belongs_to:customer
  has_many:order_details,dependent: :destroy
  enum payment_method: { credit_card: 0, transfer: 1 }

  enum status: { wait_for_payment: 0, payment_confirm: 1, in_production: 2, preparing_to_ship: 3, sent: 4 }

end
