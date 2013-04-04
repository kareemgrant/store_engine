class CategoriesController < ApplicationController
  
  def index
    @categories = Category.all
  end

  # def new
  #   @category = Category.new
  # end

#   def create
#     @category = Category.new(params[:category])

#     respond_to do |format|
#       if @category.save
#         format.html { redirect_to @category, notice: 'Category was successfully created.'}
#         format.json { render json: @category, status: :created, location: @category }
#       else
#         format.html { render action: "new" }
#         format.json { render json: @category.errors, status: :unprocessable_entity }
#       end
#     end
#   end

  def show
    @categories = Category.all
    if params[:id].nil?
      @products = Product.all
    else
      @category = Category.find(params[:id])
      @products = @category.products
    end

    if @category
      respond_to do |format|
        format.html
      end
    else
      redirect_to products_path
    end
  end

  # def edit
  #   @category = Category.find(params[:id])
  # end

  # def update
  #   @category = Category.find(params[:id])

  #   if @category.update_attributes(params[:category])
  #     redirect_to categories_path
  #   else 
  #     render :edit
  #   end
  # end

  # def destroy
  #   @category = Category.find(params[:id])
  #   @category.destroy

  #   respond_to do |format|
  #     format.html { redirect_to categories_path }
  #   end
  # end


end
