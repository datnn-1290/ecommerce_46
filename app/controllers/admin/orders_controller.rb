class Admin::OrdersController < Admin::BaseController
  def show
    order = Order.find_by id: params[:id]
    @order_details = order.order_details
    @user = order.user
  end
end
