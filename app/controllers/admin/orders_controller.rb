class Admin::OrdersController < Admin::BaseController
  def show
    @order = Order.find(params[:id])
  end

  def index
    @orders = Order.all
  end

   def add_quantity_to_order
    order = LineItem.find(params[:id]).order
    order.add_quantity(params[:id])
    redirect_to :back
  end

  def decrease_quantity_from_order
    line_item = LineItem.find(params[:id]).order
    order.decrease_quantity(params[:id])
    redirect_to :back
  end
end
