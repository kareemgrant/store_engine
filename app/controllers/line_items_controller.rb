class LineItemsController < ApplicationController

  def create
    @cart = current_cart
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product.id)
    @line_item.product = product
      
    respond_to do |format|
      if @line_item.save
        format.html { redirect_to @line_item.cart, notice: "Line Item was sucessfully created!" }
        format.json { render json: @line_item, status: :created, location: @line_item} 
      else
        format.html { redirect_to product_path(product) }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

end