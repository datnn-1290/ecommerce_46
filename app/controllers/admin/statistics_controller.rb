class Admin::StatisticsController < Admin::BaseController

  def index
    if params[:order]
      @statistic_order = true
    elsif params[:statistic]
      if params[:statistic][:type] == Settings.statistic.sell_product
        date_start = params[:statistic][:date_start]
        date_end = params[:statistic][:date_end]
        @products = Statistic.statistic_hot_product(Order.statuses[:shipped], date_start, date_end).page(params[:page]).per(Settings.admin.list.per_page)
      elsif params[:statistic][:type] == Settings.statistic.order
        date_start = params[:statistic][:date_start]
        date_end = params[:statistic][:date_end]
        status = params[:statistic][:status]
        @orders = Statistic.statistic_order(Order.statuses[status], date_start, date_end).page(params[:page]).per(Settings.admin.list.per_page)
        @statistic_order = true
      end
    end
  end
end
