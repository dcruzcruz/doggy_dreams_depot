class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id])
  end
  def index
    if params[:category_id].present?
      @category = Category.find(params[:category_id])
      @products = @category.products.page(params[:page]).per(6).order("RANDOM()")
    else
      @products = Product.page(params[:page]).per(6).order("RANDOM()")
    end
  end

  def products_list
    # Fetch all products
    @all_products = Product.order("RANDOM()")

    # If search parameters are present, filter products
    if params[:search].present?
      @all_products = @all_products.where("product_name LIKE ? OR description LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
    end

    # If category parameter is present, filter products by category
    if params[:category].present?
      @all_products = @all_products.where(category_id: params[:category])
    end

    # If reset button is clicked, show all products randomly
    if params[:reset].present?
      @all_products = @all_products.order("RANDOM()")
    end
  end
end
