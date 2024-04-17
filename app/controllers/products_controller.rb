class ProductsController < ApplicationController
  # before_action :authenticate_user!

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

  def add_to_cart
    @product = Product.find(params[:id])
    @cart_item = current_user.carts.find_by(product_id: @product.id)

    if @cart_item.present?
      # If the product is already in the cart, increment the quantity
      @cart_item.quantity += 1
      @cart_item.save
    else
      # If the product is not in the cart, create a new cart item with quantity 1
      current_user.carts.create(product: @product, quantity: 1)
    end

    redirect_to @product, notice: 'Product added to cart successfully.'
  end
end
