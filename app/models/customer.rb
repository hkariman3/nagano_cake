class Customer < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many:addresses
  has_many:cart_items
  has_many:orders

  def active_for_authentication?
    super && (is_deleted == false)
  end
end