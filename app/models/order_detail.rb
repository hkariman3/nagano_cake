class OrderDetail < ApplicationRecord
  belongs_to:order
  belongs_to:item

  enum making_status: {impossible: 0, waiting_for_production: 1, under_construction: 2, production_completed: 3 }
end
