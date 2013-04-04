class CartsController < ApplicationController
  def show
    @cart = current_cart
  end

  def destroy
    @cart = current_cart
    @cart.destroy
    session[:cart_id] = nil
    redirect_to :back
  end

  def add_quantity_to_cart
    @cart = current_cart
    @cart.add_quantity(params[:id])
    redirect_to :back
  end

  def decrease_quantity_from_cart
    @cart = current_cart
    @cart.decrease_quantity(params[:id])
    redirect_to :back
  end
end
