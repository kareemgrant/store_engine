class OrdersController < ApplicationController
  before_filter :signed_in?

  def index
    @orders = Order.find_all_by_user_id(current_user)
  end

  def new
    @cart = current_cart
    if @cart.line_items.empty?
      redirect_to products_path, notice: "Your cart is currently empty."
      return
    end

    @order = Order.new
    @address = ShippingAddress.new
  end

  def create
    @address = ShippingAddress.new(params[:address])
    @address.user_id = session[:user_id]

    @cart = current_cart

    @order = Order.new(params[:order])
    @order.add_line_items(current_cart)
    @order.total_price = @order.total_price_from_cart(current_cart)
    @order.user = current_user

    if @address.save
      @order.save
      redirect_to order_path(@order)
      @cart.destroy
      session[:cart_id] = nil
    else
      render "new"
   end
  end

  def show
    @order = Order.find(params[:id])

    if @order.user == current_user
      render "show"
    else
      redirect_to root_path, notice: "You are not authorized to view orders placed by another customer."
    end
  end

  # def edit
  #   @order = Order.find(params[:id])
  # end

  # def update
  #   @order = Order.find(params[:id])
  #   if @order.update_attributes params[:order]
  #     redirect_to order_path(@order)
  #   else
  #     render :edit
  #   end
  # end

private
  def signed_in?
    redirect_to login_path, notice: "You must be logged in to checkout." unless current_user
  end
end
