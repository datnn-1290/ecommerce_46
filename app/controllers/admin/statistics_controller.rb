class Admin::StatisticsController < Admin::BaseController

  def index
    if params[:statistic].present?
      type = params[:statistic][:type]
      if type == Settings.statistic.sell_product
        date_start = params[:statistic][:date_start]
        date_end = params[:statistic][:date_end]
        @products = Statistic.statistic_hot_product(Order.statuses[:shipped], date_start, date_end).page(params[:page]).per(Settings.admin.list.per_page)
      end
    end
  end
end
