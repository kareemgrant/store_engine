class LineItemsController < ApplicationController

  def create
    @cart = current_cart
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product.id)
    @line_item.product = product
      
    respond_to do |format|
      if @line_item.save
        format.html { redirect_to product_path(product) }
        format.js   { @current_item = @line_item }
      else
        format.html { redirect_to product_path(product), notice: 'An error occurred, please try again' }
      end
    end
  end

  def destroy
    line_item = LineItem.find(params[:id])
    line_item.destroy
    flash[:notice] = "Item has been deleted!"
    redirect_to :back
  end
end
