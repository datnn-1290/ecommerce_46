class Statistic < ApplicationRecord
  def self.statistic_hot_product status, date_start, date_end
    product_ids = OrderDetail
                  .joins("INNER JOIN orders ON order_details.order_id = orders.id")
                  .where("orders.status=? AND DATE(order_details.created_at) BETWEEN ? AND ?",status, date_start, date_end)
                  .select("product_id")
                  .group("order_details.product_id")
    Product.where("id IN (#{product_ids.to_sql})")
  end

  def self.statistic_order status, date_start, date_end
    order_ids = OrderDetail
                  .joins("INNER JOIN orders ON order_details.order_id = orders.id")
                  .where("orders.status=? AND DATE(order_details.created_at) BETWEEN ? AND ?",status, date_start, date_end)
                  .select("order_id")
                  .group("order_details.product_id")
    Order.where("id IN (#{order_ids.to_sql})")
  end
end
