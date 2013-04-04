class Admin::DashboardsController < Admin::BaseController
  def show
    @orders = Order.all
  end
end
