class Order < ApplicationRecord
  belongs_to :user
  has_many :order_details
  validates :name, presence: true
  validates :phone, presence: true, length: {maximum: Settings.user.phone.max_length}
  validates :address, presence: true, length: {maximum: Settings.user.address.max_length}
  enum status: [:deleted, :pending, :shipped]

  def place_an_order order, cart
    Order.transaction do
      order.save!
      cart.each do |item|
        order_detail = OrderDetail.new product_id: item["product_id"],
        quantity: item["quantity"], price: item["price"], order_id: order.id
        product = Product.find_by id: item["product_id"]
        quantity_update = product.quantity.to_i - item["quantity"].to_i
        Product.where(:id => item["product_id"]).update_all(:quantity => quantity_update)
        order_detail.save!
      end
    end
    rescue ActiveRecord::RecordInvalid => exception
  end
end
