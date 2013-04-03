  class ProductsController < ApplicationController
  def index
    @products = Product.page(params[:page]).per(20)
    @categories = Category.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(params[:product])
    if @product.save
      redirect_to product_path(@product), notice: "Product Added!"
    else
      render "new"
    end
  end

  def show
    @product = Product.find(params[:id])
    @cart = current_cart
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes params[:product]
      redirect_to product_path(@product)
    else
      render :edit
    end
  end

  def destroy
    product = Product.find(params[:id])
    product.destroy
    redirect_to products_path
  end
end
